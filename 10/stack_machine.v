module stack_machine (
    input           clk,
    input           rstN,
    input   [7:0]   in,
    output  [7:0]   out,
    output          error
);

reg     [7:0]   data_mem    [255:0];
reg     [7:0]   stack       [7:0]
reg     [1:12]  inst_mem    [31:0];

reg     [4:0]   pc;
reg     [2:0]   sp;

reg             s_flag = 0, z_flag = 0;
wire    [3:0]   inst_op;
wire    [7:0]   inst_value;


localparam op_pushc     = 0;
localparam op_pushmem   = 1;
localparam op_pop       = 2;
localparam op_j         = 3;
localparam op_jz        = 4;
localparam op_js        = 5;
localparam op_add       = 6;
localparam op_sub       = 7;

localparam err_addr     = 253;
localparam in_addr      = 254;
localparam out_addr     = 255;

assign inst_op          = inst_mem[pc][1:4];
assign inst_value       = inst_mem[pc][5:12];
assign out              = memory[out_addr];
assign error            = memory[err_addr][0];


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
        data_mem[err_addr]              <= (out > 127) || (in[7] == 1);

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
            op_jz: begin
                if (z_flag) begin
                    pc                  <= stack[sp - 1];
                    sp                  <= sp - 1;
                end
            end

            /* JUMP S */
            op_js: begin
                if (s_flag) begin
                    pc                  <= stack[sp - 1];
                    sp                  <= sp - 1;
                end
            end

            /* ADD */
            op_add: begin
                stack[sp - 2]           <= stack[sp - 2] + stack[sp - 1];
                sp                      <= sp - 1;
                z_flag                  <= ~|(stack[sp - 2] + stack[sp - 1]);
                s_flag                  <= $signed(stack[sp - 2] + stack[sp - 1]) < 0;
            end

            /* SUB */
            op_sub: begin
                stack[sp - 2]           <= stack[sp - 2] - stack[sp - 1];
                sp                      <= sp - 1;
                z_flag                  <= ~|(stack[sp - 2] - stack[sp - 1]);
                s_flag                  <= $signed(stack[sp - 2] - stack[sp - 1]) < 0;
            end
        endcase
    end
end

endmodule
