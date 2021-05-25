module comparator (
    input   [15:0]  a,
    input   [15:0]  b,
    output          match
);

wire    [15:0]  matches;

genvar i;
generate
    for(i = 0; i < 16; i = i + 1) begin
        assign matches[i] = a[i] === 1'bx || b[i] === 1'bx || ~(a[i] ^ b[i]);
    end
endgenerate

assign match = &matches;

endmodule


