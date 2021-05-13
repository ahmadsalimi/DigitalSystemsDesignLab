`include "macros.v"

module addsub (
    input   `complex    a,
    input   `complex    b,
    input               op,     // 0 for addition, 1 for substraction
    output  `complex    s
);

assign `Re(s) = `sRe(a) + (op ? -1 : 1) * `sRe(b);
assign `Im(s) = `sIm(a) + (op ? -1 : 1) * `sIm(b);

endmodule
