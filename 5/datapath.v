module datapath (
    input       [3:0]   A_in,
    input       [3:0]   B_in,
    input               rstN,
    input               clk,
    input       [2:0]   A_shft_amt,
    input       [2:0]   B_shft_amt,
    input               op,
    input               done,
    output reg  [7:0]   ACC,
    output reg  [3:0]   B
);

reg [7:0]   A;

always @(posedge clk or negedge rstN) begin
    if (~rstN) begin
        A <= {{4{A_in[3]}}, A_in};
        B <= {{4{B_in[3]}}, B_in};
        ACC <= 0;
    end else if (~done) begin
        B <= B >> B_shft_amt;
        ACC <= ACC + (op ? 1 : -1) * (A << A_shft_amt);
    end
end

endmodule
