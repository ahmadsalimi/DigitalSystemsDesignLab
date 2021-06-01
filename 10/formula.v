`define inst(ADDR, OP, VAL=0)    cpu.inst_mem[ADDR] = (OP << 8) | VAL

module formula;
    
reg             clk = 1, rstN = 0;
reg     [7:0]   in;
wire    [7:0]   out;
   
stack_machine cpu(clk, rstN, in, out);

assign error = (out > 127) || (in[7] == 1);
always #10 clk = ~clk;

/* Pointers to important memories */
localparam counter_p    = 7;
localparam tmp_p        = 0;

/* Address of exit program */
localparam exit         = 25;

initial begin
    /* THE CODE */

    /* counter = 3 */
    `inst(0,    cpu.op_pushc,   3);             // s_head  = 3
    `inst(1,    cpu.op_pop,     counter_p);     // counter = 3

    /* LOOP CONDITION */

    /* counter = counter - 1 */
    `inst(2,    cpu.op_pushmem, counter_p);     // s_head  = counter
    `inst(3,    cpu.op_pushc,   1);             // s_head  = 1
    `inst(4,    cpu.op_sub);                    // s_head  = counter - 1
    `inst(5,    cpu.op_pop,     counter_p);     // counter = counter - 1

    /* if (counter < 0): goto exit */
    `inst(6,    cpu.op_pushc,   exit);          // s_head  = exit
    `inst(7,    cpu.op_js);                     // if (counter == 0): goto exit
    `inst(8,    cpu.op_pop,     tmp_p);         // else: sp = sp - 1

    /* LOOP BODY */
    `inst(9,    cpu.op_pushmem, cpu.in_addr);   // s_head  = x
    `inst(10,   cpu.op_pushc,   23);            // s_head  = 23
    `inst(11,   cpu.op_add);                    // s_head  = x + 23
    `inst(12,   cpu.op_pop,     tmp_p);         // tmp     = x + 23
    `inst(13,   cpu.op_pushmem, tmp_p);         // s_head  = x + 23
    `inst(14,   cpu.op_pushmem, tmp_p);         // s_head  = x + 23
    `inst(15,   cpu.op_add);                    // s_head  = (x + 23) * 2
    `inst(16,   cpu.op_pushc,   12);            // s_head  = 12
    `inst(17,   cpu.op_sub);                    // s_head  = ((X + 23) * 2) - 12
    `inst(18,   cpu.op_pop,     cpu.out_addr);  // y       = ((X + 23) * 2) - 12

    /* jump to start of loop */
    `inst(19,   cpu.op_pushc,   2);             // s_head  = 2
    `inst(20,   cpu.op_j);                      // goto    2
end

initial begin

    #10 rstN = 1;
    wait(cpu.pc == 7);
    in = 13;
    wait(cpu.pc == 19);
    $display("((%d + 23) * 2) - 12 = %d, error = %b", $signed(in), $signed(out), error);

    wait(cpu.pc == 7);
    in = 1;
    wait(cpu.pc == 19);
    $display("((%d + 23) * 2) - 12 = %d, error = %b", $signed(in), $signed(out), error);

    wait(cpu.pc == 7);
    in = -121;
    wait(cpu.pc == 19);
    $display("((%d + 23) * 2) - 12 = %d, error = %b", $signed(in), $signed(out), error);

    wait(cpu.pc == exit);
    $stop;
end

endmodule