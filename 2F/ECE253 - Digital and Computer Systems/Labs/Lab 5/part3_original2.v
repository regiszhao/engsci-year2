module part3 (ClockIn, Resetn, Start, Letter, DotDashOut);
    input ClockIn, Resetn, Start;
    input [2:0] Letter;
    output DotDashOut;

    reg [11:0] bmc;
    reg [7:0] q = 8'b00000000;
    wire clock_signal = (q == 8'b00000000)? 1 : 0;
    reg [11:0] mc_sequence = 12'b000000000000;
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

    always @(posedge ClockIn) begin
        // if (Resetn == 0)
        //     q <= 8'b11111001;
        // else 
        if (q == 8'b00000000)
            q <= 8'b11111001;
        else
            q <= q-1;
    end

    always @(posedge clock_signal, negedge Resetn) begin
        if (Start)
            mc_sequence <= bmc;
        else if (Resetn == 0)
            mc_sequence <= 12'b000000000000;
        else
            begin
                mc_sequence[11] <= mc_sequence[10];
                mc_sequence[10] <= mc_sequence[9];
                mc_sequence[9] <= mc_sequence[8];
                mc_sequence[8] <= mc_sequence[7];
                mc_sequence[7] <= mc_sequence[6];
                mc_sequence[6] <= mc_sequence[5];
                mc_sequence[5] <= mc_sequence[4];
                mc_sequence[4] <= mc_sequence[3];
                mc_sequence[3] <= mc_sequence[2];
                mc_sequence[2] <= mc_sequence[1];
                mc_sequence[1] <= mc_sequence[0];
                mc_sequence[0] <= mc_sequence[11];
            end
    end
endmodule