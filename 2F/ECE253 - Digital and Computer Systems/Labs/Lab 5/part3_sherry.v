module part3 (ClockIn, Resetn, Start, Letter, DotDashOut);
    input ClockIn, Resetn, Start;
    input [2:0] Letter;
    output DotDashOut;

    wire[11:0] bmc; //next state

    //state table
    always @(*) begin
        case (Letter)
            3'b000: bmc = 12'b101110000000;
            3'b001: bmc = 12'b111010101000;
            3'b010: bmc = 12'b111010111010;
            3'b011: bmc = 12'b111010100000;
            3'b100: bmc = 12'b100000000000;
            3'b101: bmc = 12'b101011101000;
            3'b110: bmc = 12'b111011101000;
            3'b111: bmc = 12'b101010100000;
            default: bmc = 12'b000000000000;
        endcase
    end

    //VERILOG FOR STATE REGISTER
    reg [11:0] y;

    //state FF
    always@(posedge ClockIn)
    begin
        if (resetn)
            y <= bmc; //if reset high, start low --> dotdashout stays the same
        else
        begin
            y[0]
            ...
            y[11]
        end
    end
    
    //FSM output
    assign DotDashOut = y[2];
endmodule