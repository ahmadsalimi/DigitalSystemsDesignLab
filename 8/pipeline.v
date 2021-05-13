`include "macros.v"

module pipeline (
    input           clk,
    input           rstN
);

wire    [1:0]       i_op;
wire    [4:0]       i_waddr, i_raddr1, i_raddr2;
wire    `complex    m_rdata1, m_rdata2, alu_out;

reg     [1:0]       buff_op, op;
reg     [4:0]       buff_waddr, buff2_waddr, raddr1, raddr2, waddr;
reg     `complex    rdata1, rdata2, wdata;

inst_fetch  IF(clk, rstN, i_op, i_waddr, i_raddr1, i_raddr2);
memory      MEM(raddr1, raddr2, wdata, waddr, m_rdata1, m_rdata2);
alu         ALU(rdata1, rdata2, op, alu_out);

always @(posedge clk or negedge rstN) begin
    if (rstN) begin
        // IF
        buff_op <= i_op;
        buff_waddr <= i_waddr;
        raddr1 <= i_raddr1;
        raddr2 <= i_raddr2;
        
        // MEM
        rdata1 <= m_rdata1;
        rdata2 <= m_rdata2;
        op <= buff_op;
        buff2_waddr <= buff_waddr;

        // ALU
        waddr <= buff2_waddr;
        wdata <= alu_out;

        $display("#%d\tbuff_op=%b, buff_waddr=%d, raddr1=%d, raddr2=%d", $time,
            buff_op, buff_waddr, raddr1, raddr2);

        $display("#%d\top=%b, buff2_waddr=%d, rdata1=(%d, %d), rdata2=(%d, %d)", $time,
            op, buff2_waddr, `sRe(rdata1), `sIm(rdata1), `sRe(rdata2), `sIm(rdata2));

        $display("#%d\twaddr=%d, wdata1=(%d, %d)\n", $time,
            waddr, `sRe(wdata), `sIm(wdata));
    end
end
    
endmodule
