module comparator (
    input   a,
    input   b,
    output  g,
    output  e,
    output  l
);

assign g = ~((~a) | b);
assign e = ~(a ^ b);
assign l = ~((~b) | a);

endmodule