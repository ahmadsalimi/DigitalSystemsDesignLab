module first_one (
    input   [3:0]   in,
    output  [1:0]   index
);

assign index = {~(in[1] | in[0]), ~in[0] & (in[1] | ~in[2])};

endmodule