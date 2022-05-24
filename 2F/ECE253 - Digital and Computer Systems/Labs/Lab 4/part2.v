module part2(Clock, Reset_b, Data, Function, ALUout);
    input [3:0] Data;
    input Clock, Reset_b;
    input [2:0] Function;
    output reg [7:0] ALUout;

    wire [3:0] A, B;
	reg [7:0] preALUout;
    assign A = Data;
    assign B = ALUout[3:0];

    // ALU shit
    wire [4:0] FAsum;
    adder add(.a(A), .b(B), .c_in(1'b0), .s(FAsum[3:0]), .c_out(FAsum[4]));
	wire [4:0] regsum;
	assign regsum = A + B;
    // ALU shit

    always @(*) 
    begin
        case (Function)
            3'b000: preALUout = {3'b000, FAsum};
            3'b001: preALUout = {3'b000, regsum};
            3'b010: preALUout = {{4{B[3]}},B};
            3'b011: preALUout = {7'b0000000, (|A) | (|B)};
            3'b100: preALUout = {7'b0000000, (&A) & (&B)};
            3'b101: preALUout = {4'b0000, B} << A; //may have to convert A to integer
            3'b110: preALUout = {4'b0000, A} * {4'b0000, B};
            3'b111: preALUout = ALUout;
            default: preALUout = 8'b00000000;
        endcase
    end


    always @(posedge Clock)
    begin
        if (Reset_b == 1'b0)
            ALUout <= 8'b00000000;
        else
			ALUout <= preALUout;
    end
endmodule


module adder(a, b, c_in, s, c_out);
    input [3:0] a, b;
    input c_in;
    output [3:0] s;
    output c_out;

    wire c1, c2, c3;

    FA u0(a[0], b[0], c_in, s[0], c1);
    FA u1(a[1], b[1], c1, s[1], c2);
    FA u2(a[2], b[2], c2, s[2], c3);
    FA u3(a[3], b[3], c3, s[3], c_out);
endmodule


module FA(a, b, c_in, s, c_out);
    input a, b, c_in;
    output s, c_out;

    assign c_out = (a & b) | (c_in & a) | (c_in & b);
    assign s = c_in ^ a ^ b;
endmodule