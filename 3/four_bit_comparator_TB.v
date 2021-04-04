module four_bit_comparator_TB ();

reg [4:0]   a, b;
wire        g, e, l;

four_bit_comparator COM(
    .a(a[3:0]),
    .b(b[3:0]),
    .g_in(1'b0),
    .e_in(1'b1),
    .l_in(1'b0),
    .g_out(g),
    .e_out(e),
    .l_out(l)
);

initial begin
    $monitor("%d, %d, g = %d, e = %d, l = %d", a, b, g, e, l);
    for (a = 0; a < 16; a = a + 1) begin
        for (b = 0; b < 16; b = b + 1) begin
            #10;
        end
    end
    $stop;
end

endmodule