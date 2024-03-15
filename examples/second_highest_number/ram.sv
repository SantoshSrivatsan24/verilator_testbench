/**
 * Modeling a RAM
 *
 */

module ram #(
    parameter SIZE = 32,
    parameter ADDRW = $clog2(SIZE),
    parameter DATAW = 8
) (
    input wire clk,
    input wire reset,

    input wire [ADDRW-1:0] raddr,
    output reg [DATAW-1:0] rdata
);

    static reg [DATAW-1:0] mem [SIZE-1:0];

    function void populate_ram(string filename);
        $readmemh(filename, mem);
    endfunction

    function void dump_ram();
        for(integer i = 0; i < SIZE; i = i+1) $display("RAM[%0d] = %08x", i, mem[i]);
    endfunction

    initial begin
        populate_ram("ram.mem");
        // dump_ram();
    end

    always @(posedge clk) begin
        if (reset) begin
            rdata <= DATAW'(1'hx);
        end else begin
            rdata <= mem[raddr];
        end
    end

endmodule

