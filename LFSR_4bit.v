// LFSR_64bit module
module LFSR_64bit (
    input wire i_clk,
    input wire i_reset,
    input wire [3:0] i_seed,
    output wire [3:0] o_lfsr,
    output wire o_keystream
);

    // Internal registers
    reg [3:0] lfsr_reg;
    reg msb_lfsr;
    reg keystream_reg;

    // Combinational logic for output assignments
    assign o_lfsr = lfsr_reg;
    assign o_keystream = keystream_reg;

    // Sequential logic
    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) begin
            // Reset condition
            lfsr_reg <= i_seed;
            msb_lfsr <= 1'b0;
            keystream_reg <= i_seed[0];
        end else begin
            // Normal operation
            msb_lfsr <= lfsr_reg[3] ^ lfsr_reg[0];
            keystream_reg <= lfsr_reg[0];
            lfsr_reg <= {msb_lfsr, lfsr_reg[3:1]};
        end
    end

endmodule
