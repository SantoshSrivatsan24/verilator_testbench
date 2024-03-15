`include "utils.vh"

module top();

bit clk = 1'b0;
bit reset = 1'b0;

/* Instantiate the design */
dut DUT (
    .clk(clk),
    .reset(reset)
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
    #10 reset = 1'b0;
end

initial begin: TEST_FLOW
    /* Test flow here */
    #100 $display("DONE!");
    $finish;
end

endmodule

