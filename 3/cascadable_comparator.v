module cascadable_comparator (
    input   a,
    input   b,
    input   g_in,
    input   e_in,
    input   l_in,
    output  g_out,
    output  e_out,
    output  l_out
);

comparator COM(
    .a(a),
    .b(b),
    .g(g),
    .e(e),
    .l(l)
);

assign g_out = g_in | (e_in & g);
assign e_out = e_in & e;
assign l_out = l_in | (e_in & l);

endmodule