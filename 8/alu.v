`include "macros.v"

module alu (
    input   `complex    a,
    input   `complex    b,
    input   [1:0]       op,
    output  `complex    s
);

wire    `complex    addsub_res, mul_res;
addsub  ADDSUB (a, b, op[0], addsub_res);
mul     MUL (a, b, mul_res);

assign s = op[1] ? mul_res : addsub_res;

endmodule
