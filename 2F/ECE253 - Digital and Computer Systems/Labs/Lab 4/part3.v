module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
    input clock, reset, ParallelLoadn, RotateRight, ASRight;
    input [7:0] Data_IN;
    output [7:0] Q;

    wire left_of_left_bit = ASRight ? Q[7] : Q[0];

    subcircuit s0(
        .right(Q[7]),
        .left(Q[1]),
        .LoadLeft(RotateRight),
        .D(Data_IN[0]),
        .loadn(ParallelLoadn),
        .clock1(clock),
        .reset1(reset),
        .Q_out(Q[0])
    );

    subcircuit s1(
        .right(Q[0]),
        .left(Q[2]),
        .LoadLeft(RotateRight),
        .D(Data_IN[1]),
        .loadn(ParallelLoadn),
        .clock1(clock),
        .reset1(reset),
        .Q_out(Q[1])
    );

    subcircuit s2(
        .right(Q[1]),
        .left(Q[3]),
        .LoadLeft(RotateRight),
        .D(Data_IN[2]),
        .loadn(ParallelLoadn),
        .clock1(clock),
        .reset1(reset),
        .Q_out(Q[2])
    );

    subcircuit s3(
        .right(Q[2]),
        .left(Q[4]),
        .LoadLeft(RotateRight),
        .D(Data_IN[3]),
        .loadn(ParallelLoadn),
        .clock1(clock),
        .reset1(reset),
        .Q_out(Q[3])
    );

    subcircuit s4(
        .right(Q[3]),
        .left(Q[5]),
        .LoadLeft(RotateRight),
        .D(Data_IN[4]),
        .loadn(ParallelLoadn),
        .clock1(clock),
        .reset1(reset),
        .Q_out(Q[4])
    );

    subcircuit s5(
        .right(Q[4]),
        .left(Q[6]),
        .LoadLeft(RotateRight),
        .D(Data_IN[5]),
        .loadn(ParallelLoadn),
        .clock1(clock),
        .reset1(reset),
        .Q_out(Q[5])
    );

    subcircuit s6(
        .right(Q[5]),
        .left(Q[7]),
        .LoadLeft(RotateRight),
        .D(Data_IN[6]),
        .loadn(ParallelLoadn),
        .clock1(clock),
        .reset1(reset),
        .Q_out(Q[6])
    );

    subcircuit s7(
        .right(Q[6]),
        .left(left_of_left_bit),
        .LoadLeft(RotateRight),
        .D(Data_IN[7]),
        .loadn(ParallelLoadn),
        .clock1(clock),
        .reset1(reset),
        .Q_out(Q[7])
    );
endmodule



module subcircuit (right, left, LoadLeft, D, loadn, clock1, reset1, Q_out);
    input right, left, LoadLeft, D, loadn, clock1, reset1;
    output Q_out;
    wire bit_to_load;
    wire dff_input;

    mux2to1 left_or_right(
        .x(right),
        .y(left),
        .s(LoadLeft),
        .m(bit_to_load)
    );

    mux2to1 rotate_or_parallel(
        .x(D),
        .y(bit_to_load),
        .s(loadn),
        .m(dff_input)
    );

    flipflop dff(
        .d(dff_input),
        .q(Q_out),
        .clock0(clock1),
        .reset0(reset1)
    );
endmodule



module flipflop(d, q, clock0, reset0);
    input d, clock0, reset0;
    output reg q;

    always @(posedge clock0)
    begin
        if (reset0 == 1'b1)
            q <= 0;
        else
            q <= d;
    end
endmodule



module mux2to1(x, y, s, m);
    input x; //select 0
    input y; //select 1
    input s; //select signal
    output m; //output
  
    assign m = s ? y : x;
endmodule