`include "macros.v"

module memory #(
    parameter   DEPTH = 32,
    parameter   A_LEN = 5
) (
    input   [A_LEN:1]       raddr1,
    input   [A_LEN:1]       raddr2,
    input   `complex        wdata,
    input   [A_LEN:1]       waddr,
    output  `complex    rdata1,
    output  `complex    rdata2
);

reg `complex    mem [DEPTH-1:0];

assign rdata1 = mem[raddr1];
assign rdata2 = mem[raddr2];
always @(*) mem[waddr] <= wdata;

endmodule
