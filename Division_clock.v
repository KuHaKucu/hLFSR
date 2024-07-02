// This module divides the input clock by a factor of 'n'
// The output clock is asserted high for half the period of the input clock
module Division_clock #(
    parameter n = 10 // Division factor
) (
    input wire clk, // Input clock
    output wire clk_out // Output clock
);

// Internal signals
reg [log2(n)-1:0] counter; // Counter to track clock cycles
wire clk_out_int; // Internal signal for clock output

// Calculate the log2 of the division factor
function integer log2;
    input integer value;
    begin
        value = value - 1;
        for (log2 = 0; value > 0; log2 = log2 + 1)
            value = value >> 1;
    end
endfunction

// Clock divider logic
always @(posedge clk) begin
    if (counter == n-1) begin
        counter <= 0;
    end else begin
        counter <= counter + 1;
    end
end

// Output clock logic
assign clk_out_int = (counter == n/2) ? 1'b1 : 1'b0;

// Assign output clock
assign clk_out = clk_out_int;

endmodule
