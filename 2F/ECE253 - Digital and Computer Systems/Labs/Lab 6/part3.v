// DataIn - input data port
// Resetn - synchronous reset
// Go signal starts things
// DataResult - register at output of ALU

module part3(Clock, Resetn, Go, Divisor, Dividend, Quotient, Remainder);
    input Clock, Resetn, Go;
    input [3:0] Divisor, Dividend;
    output [3:0] Quotient, Remainder;

    // lots of wires to connect our datapath and control
    // wire [2:0] counter;
    wire ld_a, ld_div, ld_dend, ld_r;
    wire ld_alu_out;
    wire alu_select;
    wire alu_op;
    
    wire [8:0] division_result;

    control C0(
        .clk(Clock),
        .resetn(Resetn),
        // .counter(counter),
        
        .go(Go),
        
        .ld_alu_out(ld_alu_out), 
        .ld_a(ld_a),
        .ld_div(ld_div),
        .ld_dend(ld_dend), 
        .ld_r(ld_r), 
        
        .alu_select(alu_select),
        .alu_op(alu_op)
    );

    datapath D0(
        .clk(Clock),
        .resetn(Resetn),

        .ld_alu_out(ld_alu_out), 
        .ld_a(ld_a),
        .ld_div(ld_div),
        .ld_dend(ld_dend), 
        .ld_r(ld_r), 

        .alu_select(alu_select),
        .alu_op(alu_op),

        .divisor(Divisor),
        .dividend(Dividend),
        .division_result(division_result)
    );

    assign Quotient = division_result[3:0];
    assign Remainder = division_result[7:4];
                
 endmodule             
                

module control(
    input clk,
    input resetn,
    input go,
    
    // reg [2:0] counter,

    output reg ld_a, ld_div, ld_dend, ld_r,
    output reg ld_alu_out,
    output reg alu_select,
    output reg alu_op
    );

    reg [1:0] current_state, next_state;
    reg [2:0] counter = 3'b000; // resets after 4 shifts
    
    localparam  S_LOAD      = 2'b00,
                S_CYCLE_0   = 2'b01,
                S_CYCLE_1   = 2'b10;
    
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
            case (current_state)
                S_LOAD: next_state = go ? S_CYCLE_0 : S_LOAD; // Loop in current state until value is input
                S_CYCLE_0: next_state = S_CYCLE_1; // Loop in current state until go signal goes low
                S_CYCLE_1: next_state = (counter == 3'b100) ? S_LOAD : S_CYCLE_0; // Loop in current state until value is input
            default:     next_state = S_LOAD;
        endcase
    end // state_table
   

    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        ld_alu_out = 1'b0;
        ld_a = 1'b0;
        ld_div = 1'b0;
        ld_dend = 1'b0;
        ld_r = 1'b0;
        alu_select = 1'b0;
        alu_op = 1'b0;

        case (current_state)
            S_LOAD: begin // load everything in
                ld_a = 1'b1;
                ld_div = 1'b1;
                ld_dend = 1'b1;
                counter = 3'b000;
                end
            S_CYCLE_0: begin
                ld_alu_out = 1'b1; ld_a = 1'b1; ld_dend = 1'b1; // store output in A and dend
                alu_select = 1'b0; // choose dend input
                alu_op = 1'b0; // shift bits
                counter = counter + 1; // increment counter
            end
            S_CYCLE_1: begin
                alu_select = 1'b1; // choose div input
                alu_op = 1'b1; // subtract and cases for MSB of A
                if (counter == 3'b100) begin
                    ld_r = 1;
                    // counter = 3'b000;
                end
                else begin
                    ld_alu_out = 1'b1; ld_a = 1'b1; ld_dend = 1'b1; // store output in A and dend
                end
            end
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_LOAD;
        else
            current_state <= next_state;
    end // state_FFS
endmodule



module datapath(
    input clk,
    input resetn,
    input [3:0] divisor, dividend,
    input ld_alu_out, 
    input ld_div, ld_a, ld_dend,
    input ld_r,
    input alu_op, 
    input alu_select, //only aluselect is between div and dend (A is always an input into alu)
    output reg [8:0] division_result
    );
    
    // input registers: A is only 5 bit register, div and dend are 4 bit
    reg [4:0] a;
    reg [3:0] div, dend;

    // output of the alu: first 5 digits is A or quotient, last 4 is dividend
    reg [8:0] alu_out;
    // alu input muxes
    reg [3:0] alu_d_input;
    reg [4:0] subtract_result;

    // counter to count how many shifts (stop when reached 4)
    // reg [2:0] counter = 3'b000;
    
    // Registers a, div, dend, with respective input logic
    always@(posedge clk) begin
        if(!resetn) begin
            a <= 5'b00000; 
            div <= 4'b0000; 
            dend <= 4'b0000; 
        end
        else begin
            if(ld_a)
                a <= ld_alu_out ? alu_out[8:4] : 5'b00000; // load alu_out if load_alu_out signal is high, otherwise load 0
            if(ld_dend)
                dend <= ld_alu_out ? alu_out[3:0] : dividend; // load alu_out if load_alu_out signal is high, otherwise load from dividend
            if(ld_div)
                div <= divisor; // always load divisor
        end
    end
 
    // Output result register
    always@(posedge clk) begin
        if(!resetn) begin
            division_result <= 9'b000000000; 
        end
        else 
            if(ld_r)
                division_result <= alu_out;
    end

    // The ALU input multiplexers
    always @(*)
    begin
        case (alu_select)
            1'b0:
                alu_d_input = dend;
            1'b1:
                alu_d_input = div;
            //default: don't need default (all cases covered)
        endcase
    end

    // The ALU 
    always @(*)
    begin : ALU
        // alu
        case (alu_op)
            0: begin //joins a and dend, shifts everything left one bit, adds 1 to counter
                   alu_out = {a, alu_d_input} << 1; 
                //    counter = counter + 1;
               end
            1: begin //checks if MSB of register A is 1, etc.
                   subtract_result = a - alu_d_input;
                   alu_out = (subtract_result[4]) ? {a, {dend[3:1], 1'b0}} : {subtract_result, {dend[3:1], 1'b1}};
                //    alu_out = ((a - alu_d_input)[4]) ? {a, {dend[3:1], 1'b0}} : {(a - alu_d_input), {dend[3:1], 1'b1}};
               end
            default: alu_out = 8'b0;
        endcase
    end
    
endmodule
