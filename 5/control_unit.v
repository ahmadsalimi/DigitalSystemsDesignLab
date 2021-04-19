module control_unit (
    input   [3:0]   B,
    input           rstN,
    input           clk,
    output  [2:0]   A_shft_amt,
    output  [2:0]   B_shft_amt,
    output          op,     // 0: subtract, 1: add
    output          done
);

reg     [2:0]   shifted;
reg             first_clock;
wire    [1:0]   one_index;
wire    [2:0]   zero_index;

first_one   FO (B, one_index);
first_zero  FZ (B, zero_index);

assign op = B[0] & (~first_clock);
assign B_shft_amt = op ? zero_index : {1'b0, one_index};
assign A_shft_amt = shifted + B_shft_amt;
assign done = shifted + B_shft_amt > 3;

always @(posedge clk or negedge rstN) begin
    if (~rstN) begin
        shifted <= 0;
        first_clock <= 1;
    end else begin
        first_clock <= 0;
        shifted <= shifted + B_shft_amt;
    end
end
    
endmodule
