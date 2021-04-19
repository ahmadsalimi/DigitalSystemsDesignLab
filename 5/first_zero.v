module first_zero (
    input   [3:0]   in,
    output  [2:0]   index
);

assign index[2] = in[3] & in[2] & in[1] & in[0];
assign index[1] = in[1] & in[0] & (~(in[3] & in[2]));
assign index[0] = in[0] & (~in[1] | in[2]);

endmodule