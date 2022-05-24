module part3 (ClockIn, Resetn, Start, Letter, DotDashOut);
    input ClockIn, Resetn, Start;
    input [2:0] Letter;
    output DotDashOut;

    wire [11:0] bmc;
    wire morse_clock_signal; //completes cycle every 0.5 seconds
    wire [11:0] mc_sequence;
    assign DotDashOut = mc_sequence[11];

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

    rate_divider RD (
        .ClockIn(ClockIn), .Reset(Resetn), .RateDivider(8'b11111001), .ClockOut(morse_clock_signal)
    );

    shift12 shifter(
        .R(bmc), .L(Start), .Clock(morse_clock_signal), .Reset(Resetn), .Q(mc_sequence)
    );

endmodule


module rate_divider (ClockIn, Reset, RateDivider, ClockOut);
    input ClockIn, Reset;
    input [7:0] RateDivider;
    output reg ClockOut;

    reg [7:0] q;
    assign ClockOut = (q == 8'b00000000)? 1 : 0;

    always @(posedge ClockIn, negedge Reset) begin
        if (Reset == 0)
            q <= RateDivider;
        else if (q == 8'b00000000)
            q <= RateDivider;
        else
            q <= q-1;
    end
endmodule


module shift12 (R, L, Clock, Reset, Q);
    input [11:0] R;
    input L, w, Clock;
    output reg [11:0] Q;

    always @(posedge Clock) begin
        if (L)
            Q <= R;
        else if (Reset == 0)
            Q <= 8'b000000000000;
        else
            begin
                Q[11] <= Q[10];
                Q[10] <= Q[9];
                Q[9] <= Q[8];
                Q[8] <= Q[7];
                Q[7] <= Q[6];
                Q[6] <= Q[5];
                Q[5] <= Q[4];
                Q[4] <= Q[3];
                Q[3] <= Q[2];
                Q[2] <= Q[1];
                Q[1] <= Q[0];
                Q[0] <= Q[11];
            end
    end
endmodule