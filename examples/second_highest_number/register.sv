module register #(
    parameter SIZE = 32
) (
    input wire clk,
    input wire reset,
    input wire en,
    input wire [SIZE-1:0] D,
    output wire [SIZE-1:0] Q
);

reg [SIZE-1:0] r;

always @(posedge clk) begin
   if (reset) begin
        r <= 'b0;
   end else begin
        if (en) r <= D;
   end
end

assign Q = r;

endmodule

