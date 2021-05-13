module inst_fetch (
    input           clk,
    input           rstN,
    output  [1:0]   op,
    output  [4:0]   waddr,
    output  [4:0]   raddr1,    
    output  [4:0]   raddr2   
);

localparam  DEPTH = 32;
localparam  A_LEN = 5;

reg [1:17]      mem [DEPTH-1:0];
reg [A_LEN:1]   pc;

assign op       = mem[pc][1:2];
assign waddr    = mem[pc][3:7];
assign raddr1   = mem[pc][8:12];
assign raddr2   = mem[pc][13:17];

always @(posedge clk or negedge rstN)
    pc <= rstN ? (pc + 1) : 0;

endmodule
