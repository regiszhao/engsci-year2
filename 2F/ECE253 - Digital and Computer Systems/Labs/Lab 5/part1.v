module part1 (Clock, Enable, Clear_b, CounterValue);
    input Clock, Enable, Clear_b;
    output [7:0] CounterValue;
	
	wire [6:0] ea;
	assign ea[0] = Enable & CounterValue[0];
	assign ea[1] = ea[0] & CounterValue[1];
	assign ea[2] = ea[1] & CounterValue[2];
	assign ea[3] = ea[2] & CounterValue[3];
	assign ea[4] = ea[3] & CounterValue[4];
	assign ea[5] = ea[4] & CounterValue[5];
	assign ea[6] = ea[5] & CounterValue[6];

    TFF tff0(
        .T(Enable), .clock(Clock), .clear_b(Clear_b), .Q(CounterValue[0])
    );

    TFF tff1(
        .T(ea[0]), .clock(Clock), .clear_b(Clear_b), .Q(CounterValue[1])
    );

    TFF tff2(
        .T(ea[1]), .clock(Clock), .clear_b(Clear_b), .Q(CounterValue[2])
    );

    TFF tff3(
        .T(ea[2]), .clock(Clock), .clear_b(Clear_b), .Q(CounterValue[3])
    );

    TFF tff4(
        .T(ea[3]), .clock(Clock), .clear_b(Clear_b), .Q(CounterValue[4])
    );

    TFF tff5(
        .T(ea[4]), .clock(Clock), .clear_b(Clear_b), .Q(CounterValue[5])
    );

    TFF tff6(
        .T(ea[5]), .clock(Clock), .clear_b(Clear_b), .Q(CounterValue[6])
    );

    TFF tff7(
        .T(ea[6]), .clock(Clock), .clear_b(Clear_b), .Q(CounterValue[7])
    );
endmodule


module TFF (T, clock, clear_b, Q);
    input T, clock, clear_b;
    output reg Q;

    always @(posedge clock, negedge clear_b) begin
        if (clear_b == 0)
            Q <= 1'b0;
        else
            if (T == 1)
                Q <= !Q;
            else
                Q <= Q;
    end
endmodule