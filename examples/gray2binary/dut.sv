/**
 * Design Under Test - gray code to binary converter
 *
 */

module dut #(
    parameter N = 4
)(
    input wire clk,
    input wire reset,
    input wire [N-1:0] gray,
    output reg [N-1:0] bin
);
    
    always @(posedge clk) begin
        if (reset);
    end

    always_comb begin
        for (int i = 0; i < N; i++) begin
            bin[i] = ^(gray >> i);
        end
    end

    `UNUSED_VAR(reset)

endmodule
