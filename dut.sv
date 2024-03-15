/**
 * Design Under Test
 *
 */

module dut #(
)(
    input wire clk,
    input wire reset
);
    
    always @(posedge clk) begin
        if (reset);
    end

endmodule

