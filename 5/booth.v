module booth (
    input   [3:0]   A_in,
    input   [3:0]   B_in,
    input           rstN,
    input           clk,
    output  [7:0]   res,
    output          done
);

wire [2:0]  A_shft_amt;
wire [2:0]  B_shft_amt;
wire [3:0]  B;

control_unit CU (B, rstN, clk, A_shft_amt, B_shft_amt, op, done);
datapath DP (A_in, B_in, rstN, clk, A_shft_amt, B_shft_amt, op, done, res, B);

endmodule
