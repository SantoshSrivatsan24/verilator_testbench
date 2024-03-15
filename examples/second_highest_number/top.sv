`include "utils.vh"

module top();

bit clk = 1'b0;
bit reset = 1'b0;

wire [31:0] highest, second_highest;

/* Instantiate the design */
dut #(.N(32)) DUT (
    .clk(clk),
    .reset(reset),
    .highest_out (highest),
    .second_highest_out (second_highest)
);

initial begin
    $dumpfile("trace.vcd");
    $dumpvars;
    $timeformat(-9, 2, " ns", 0);
end

initial begin : CLK_GEN
    forever #5 clk = ~clk;
end

initial begin: RST_GEN
    #5 reset = 1'b1;
    #5 reset = 1'b0;
end

initial begin: TEST_FLOW
    /* Test flow here */
    #1000 $display("DONE!");
    $finish;
end

initial begin : MONITOR
    forever begin
        @(highest or second_highest);
        $display("%t: highest = 0x%8x, second highest = 0x%8x", $time, highest, second_highest);
    end
end


endmodule

