`include "macros.v"

module addsub_TB ();

reg     `complex    a, b;
reg                 op;
wire    `complex    s;

addsub  ADDSUB(a, b, op, s);

wire [7:0] op_char;
assign op_char = op ? "-" : "+";

integer i;
initial begin
    $monitor("(%d, %d) %s (%d, %d) = (%d, %d)",
             `sRe(a), `sIm(a), op_char, `sRe(b), `sIm(b), `sRe(s), `sIm(s));

    `Re(a) = -10;
	`Im(a) = 15;
    `Re(b) = 13;
	`Im(b) = -18;
    op = 1;
    #10;
    `Re(a) = 16;
	`Im(a) = 3;
    `Re(b) = 12;
	`Im(b) = -64;
    op = 0;
    #10;
    `Re(a) = 2;
	`Im(a) = 18;
    `Re(b) = -50;
	`Im(b) = 32;
    op = 0;
    #10;
    `Re(a) = 54;
	`Im(a) = 31;
    `Re(b) = -12;
	`Im(b) = -37;
    op = 1;
    #10;
    $stop;
end

endmodule
