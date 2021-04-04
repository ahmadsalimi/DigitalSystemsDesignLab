module four_bit_comparator (
    input   [3:0]   a,
    input   [3:0]   b,
    input           g_in,
    input           e_in,
    input           l_in,
    output          g_out,
    output          e_out,
    output          l_out
);

cascadable_comparator COM3(
    .a(a[3]),
    .b(b[3]),
    .g_in(g_in),
    .e_in(e_in),
    .l_in(l_in),
    .g_out(g3),
    .e_out(e3),
    .l_out(l3)
);

cascadable_comparator COM2(
    .a(a[2]),
    .b(b[2]),
    .g_in(g3),
    .e_in(e3),
    .l_in(l3),
    .g_out(g2),
    .e_out(e2),
    .l_out(l2)
);

cascadable_comparator COM1(
    .a(a[1]),
    .b(b[1]),
    .g_in(g2),
    .e_in(e2),
    .l_in(l2),
    .g_out(g1),
    .e_out(e1),
    .l_out(l1)
);

cascadable_comparator COM0(
    .a(a[0]),
    .b(b[0]),
    .g_in(g1),
    .e_in(e1),
    .l_in(l1),
    .g_out(g_out),
    .e_out(e_out),
    .l_out(l_out)
);

endmodule