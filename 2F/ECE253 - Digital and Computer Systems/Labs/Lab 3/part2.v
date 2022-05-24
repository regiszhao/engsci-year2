module part2(a, b, c_in, s, c_out);
    input [3:0] a, b;
    input c_in;
    output [3:0] s, c_out;

    FA u0(.a(a[0]), .b(b[0]), .c_in(c_in), .s(s[0]), .c_out(c_out[0]));
    FA u1(.a(a[1]), .b(b[1]), .c_in(c_out[0]), .s(s[1]), .c_out(c_out[1]));
    FA u2(.a(a[2]), .b(b[2]), .c_in(c_out[1]), .s(s[2]), .c_out(c_out[2]));
    FA u3(.a(a[3]), .b(b[3]), .c_in(c_out[2]), .s(s[3]), .c_out(c_out[3]));
endmodule


module FA(a, b, c_in, s, c_out);
    input a, b, c_in;
    output s, c_out;

    assign c_out = (a & b) | (c_in & a) | (c_in & b);
    assign s = c_in ^ a ^ b;
endmodule