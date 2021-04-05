module serial_comparator_TB ();

reg [4:0]   a, b;
reg         reset = 1, clock = 0;
integer     i;
wire        g, e, l;

always #10 clock = ~clock;

serial_comparator COM(
    .a(a[i]),
    .b(b[i]),
    .reset(reset),
    .clock(clock),
    .g(g),
    .e(e),
    .l(l)
);

initial begin
    for (a = 0; a < 16; a = a + 1) begin
        for (b = 0; b < 16; b = b + 1) begin
            #20 reset = 0;
            for (i = 3; i >= 0; i = i - 1) begin
                #20;
            end
            $display("%d, %d, g = %d, e = %d, l = %d", a, b, g, e, l);
            reset = 1;
        end
    end
    $stop;
end

endmodule