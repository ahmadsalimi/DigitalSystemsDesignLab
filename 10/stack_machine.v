module stack_machine (
    input           clk,
    input           rstN,
    input   [7:0]   in,
    output  [7:0]   out
);

reg     [7:0]   data_mem    [255:0];
reg     [7:0]   stack       [7:0];
reg     [1:12]  inst_mem    [31:0];

reg     [4:0]   pc;
reg     [2:0]   sp;

reg             s_flag = 0, z_flag = 0;
wire    [3:0]   inst_op;
wire    [7:0]   inst_value;
wire    [7:0]   add_result, sub_result;


parameter op_pushc      = 0;
parameter op_pushmem    = 1;
parameter op_pop        = 2;
parameter op_j          = 3;
parameter op_jz         = 4;
parameter op_js         = 5;
parameter op_add        = 6;
parameter op_sub        = 7;

parameter in_addr       = 254;
parameter out_addr      = 255;

assign inst_op          = inst_mem[pc][1:4];
assign inst_value       = inst_mem[pc][5:12];
assign out              = data_mem[out_addr];
assign add_result       = stack[sp - 2] + stack[sp - 1];
assign sub_result       = stack[sp - 2] - stack[sp - 1];


integer i;
always @(posedge clk or negedge rstN) begin
    if (~rstN) begin
        pc                              <= 0;
        sp                              <= 0;
        s_flag                          <= 0;
        z_flag                          <= 0;
        for (i = 0; i < 8; i = i + 1)
            stack[i]                    <= 0;
    end
    else begin
        data_mem[in_addr]               <= in;

        pc                              <= pc + 1;
        case (inst_op)
            /* PUSH CONSTANT */
            op_pushc: begin
                stack[sp]               <= inst_value;
                sp                      <= sp + 1;
            end

            /* PUSH MEMORY */
            op_pushmem: begin
                stack[sp]               <= data_mem[inst_value];
                sp                      <= sp + 1;
            end

            /* POP */
            op_pop: begin
                data_mem[inst_value]    <= stack[sp - 1];
                sp                      <= sp - 1;
            end

            /* JUMP */
            op_j: begin
                pc                      <= stack[sp - 1];
                sp                      <= sp - 1;
            end


            /* JUMP Z */
            op_jz: if (z_flag) begin
                pc                      <= stack[sp - 1];
                sp                      <= sp - 1;
            end

            /* JUMP S */
            op_js: if (s_flag) begin
                pc                      <= stack[sp - 1];
                sp                      <= sp - 1;
            end

            /* ADD */
            op_add: begin
                stack[sp - 2]           <= add_result;
                sp                      <= sp - 1;
                z_flag                  <= ~|add_result;
                s_flag                  <= $signed(add_result) < 0;
            end

            /* SUB */
            op_sub: begin
                stack[sp - 2]           <= sub_result;
                sp                      <= sp - 1;
                z_flag                  <= ~|sub_result;
                s_flag                  <= $signed(sub_result) < 0;
            end
        endcase
    end
end

endmodule
