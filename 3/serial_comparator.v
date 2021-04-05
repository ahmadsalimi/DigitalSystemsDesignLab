module serial_comparator (
    input   a,
    input   b,
    input   reset,
    input   clock,
    output  g,
    output  e,
    output  l
);

wire g_d, g_i1, g_i2, g_not;
wire e_d, e_i1, e_i2, e_not;
wire l_d, l_i1, l_i2, l_not;

/* g reg (g_d is input) */
assign g_i1     = ~(clock & g_d);
assign g_i2     = ~(clock & ~g_d);
assign g        = ~(g_i1 & g_not);
assign g_not    = ~(g_i2 & g);
/* g reg */

/* e reg (e_d is input) */
assign e_i1     = ~(clock & e_d);
assign e_i2     = ~(clock & ~e_d);
assign e        = ~(e_i1 & e_not);
assign e_not    = ~(e_i2 & e);
/* e reg */

/* l reg (l_d is input) */
assign l_i1     = ~(clock & l_d);
assign l_i2     = ~(clock & ~l_d);
assign l        = ~(l_i1 & l_not);
assign l_not    = ~(l_i2 & l);
/* l reg */


assign g_d = ~reset & (g | (e & ~((~a) | b)));
assign e_d = reset | (e & ~(a ^ b));
assign l_d = ~reset & (l | (e & ~((~b) | a)));

endmodule