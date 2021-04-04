module serial_comparator (
    input   a,
    input   b,
    input   reset,
    input   clock,
    output  g,
    output  e,
    output  l
);

/* g reg (g_d is input) */
assign g_p1     = ~(clock & g_p3);
assign g_p2     = ~(clock & g_p1 & g_p4);
assign g_p3     = ~(g_p1 & g_p4);
assign g_p3     = ~(g_p2 & g_d);
assign g        = ~(g_p1 & g_not);
assign g_not    = ~(g_p2 & g);
/* g reg */

/* e reg (e_d is input) */
assign e_p1     = ~(clock & e_p3);
assign e_p2     = ~(clock & e_p1 & e_p4);
assign e_p3     = ~(e_p1 & e_p4);
assign e_p3     = ~(e_p2 & e_d);
assign e        = ~(e_p1 & e_not);
assign e_not    = ~(e_p2 & g);
/* g reg */

/* l reg (l_d is input) */
assign l_p1     = ~(clock & l_p3);
assign l_p2     = ~(clock & l_p1 & l_p4);
assign l_p3     = ~(l_p1 & l_p4);
assign l_p3     = ~(l_p2 & l_d);
assign l        = ~(l_p1 & l_not);
assign l_not    = ~(l_p2 & g);
/* g reg */


assign g_d = g | (e & ~((~a) | b));
assign e_d = e & ~(a ^ b);
assign l_d = l | (e & ~((~b) | a));

endmodule