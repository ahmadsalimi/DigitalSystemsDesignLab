`include "macros.v"

module mul_TB ();

reg     `complex    a, b;
wire    `complex    s;

mul     MUL(a, b, s);

integer i;
initial begin
    $monitor("(%d, %d) * (%d, %d) = (%d, %d)",
             `sRe(a), `sIm(a), `sRe(b), `sIm(b), `sRe(s), `sIm(s));
    
    `Re(a) = -10;
	`Im(a) = 5;
    `Re(b) = 3;
	`Im(b) = -8;
    #10;
    `Re(a) = 6;
	`Im(a) = 3;
    `Re(b) = 2;
	`Im(b) = -6;
    #10;
    `Re(a) = 2;
	`Im(a) = 8;
    `Re(b) = -0;
	`Im(b) = 2;
    #10;
    `Re(a) = 4;
	`Im(a) = 1;
    `Re(b) = -2;
	`Im(b) = -7;
    #10;
    $stop;
end

endmodule
