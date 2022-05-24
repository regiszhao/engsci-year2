module part2 (ClockIn, Reset, Speed, CounterValue);
    input ClockIn, Reset;
    input [1:0] Speed;
    output reg [3:0] CounterValue;

    reg [10:0] RateDivider;
    reg [10:0] q_RD;
    wire EnableDC;

    assign EnableDC = (q_RD == 11'b00000000000)? 1 : 0;

    always @(*) begin
        case (Speed)
            2'b00: RateDivider = 11'b00000000001;
            2'b01: RateDivider = 11'b00111110011;
            2'b10: RateDivider = 11'b01111100111;
            2'b11: RateDivider = 11'b11111001111;
            default: RateDivider = 11'b00000000000;
        endcase
    end

    always @(posedge ClockIn) begin
        if (Reset) begin
            q_RD <= 11'b00000000001; // Reset resets to full clock rate
			CounterValue <= 4'b0000;
		end
		else if (RateDivider == 11'b00000000001)
			CounterValue <= CounterValue + 1;
        else if (q_RD == 11'b00000000000)
            q_RD <= RateDivider;
        else
            q_RD <= q_RD-1;
    end

    always @(posedge EnableDC) begin
        CounterValue <= CounterValue + 1;
    end

endmodule