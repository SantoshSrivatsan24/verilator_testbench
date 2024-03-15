/**
 * Design Under Test:
 * Design a circuit to find the highest and second highest
 * values from a set of binary numbers (stored in a RAM) using the least
 * amount of comparators
 *
 */

module dut #(
    parameter N = 4
)(
    input wire clk,
    input wire reset,
    output wire [N-1:0] highest_out,
    output wire [N-1:0] second_highest_out
);

    /* RAM size */
    localparam SIZE = 32;
    localparam ADDRW = $clog2(SIZE);

    wire [ADDRW-1:0] raddr_in;
    wire [ADDRW-1:0] raddr_out;
    wire [N-1:0] rdata;
    wire [N-1:0] highest_in;
    wire [N-1:0] second_highest_in;

    /* Identify and name registers */
    register #(.SIZE(N)) r_highest (clk, reset, 1'b1, highest_in, highest_out);
    register #(.SIZE(N)) r_second_highest (clk, reset, 1'b1, second_highest_in, second_highest_out);
    register #(.SIZE(ADDRW)) r_raddr (clk, reset, 1'b1, raddr_in, raddr_out);

    /* Instantiate RAM module */
    ram #(
        .SIZE (SIZE),
        .DATAW (N)
    ) RAM  (
        .clk (clk),
        .reset (reset),
        .raddr (raddr_out),
        .rdata (rdata)
    );

    /* Increment read address every cycle */
    assign raddr_in = raddr_out + 1'b1;

    assign highest_in = (rdata > highest_out) ? rdata : highest_out;
    /* The second highest value is the previous highest value */
    assign second_highest_in = (rdata > highest_out) ? highest_out : second_highest_out;
    
endmodule
