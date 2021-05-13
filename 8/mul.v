`include "macros.v"

module mul (
    input   `complex    a,
    input   `complex    b,
    output  `complex    s
);

assign `Re(s) = `sRe(a) * `sRe(b) - `sIm(a) * `sIm(b);
assign `Im(s) = `sRe(a) * `sIm(b) + `sIm(a) * `sRe(b);

endmodule
