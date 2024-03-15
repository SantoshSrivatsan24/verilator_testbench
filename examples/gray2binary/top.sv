`include "utils.vh"

module top();

bit clk = 1'b0;
bit reset = 1'b0;

bit [2:0] gray, bin;

// Instantiate the design
dut #(.N(3)) DUT (
    .clk(clk),
    .reset(reset),
    .gray(gray),
    .bin(bin)
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
    // Test flow here
    #20 gray = 3'b001;
    #20 gray = 3'b101;
    #20 gray = 3'b110;

    #100 $display("DONE!");
    $finish;
end

initial begin : MONITOR
    forever begin
        @(gray);
        $display("%t: gray = %b, binary = %b", $time, gray, bin);
    end
end


endmodule

