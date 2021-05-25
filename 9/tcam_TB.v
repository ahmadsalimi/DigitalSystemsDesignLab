module tcam_TB;

reg             clk = 1, rstN = 0;
reg             we = 0;
reg             [3:0] waddr;
reg             [15:0] data;
reg             search = 0;
wire    [3:0]   saddr;
wire    [15:0]  sdata;
wire            found;

tcam TCAM(clk, rstN, we, waddr, data, search, saddr, sdata, found);

always #5 clk = ~clk;

initial
    begin

    #25 rstN = 1;
	#10 we = 1;

    waddr = 0;
    data = 16'b00000101x1010101;
    
    #10;

    waddr = 4;
    data = 16'b00000101010x0101;

    #10;

    waddr = 10;
	data = 16'bx0110101010x1x01;

    #10;

    waddr = 13;
	data = 16'b101101010101xxx1;

    #10;

    $display(" 0:%b\n 1:%b\n 2:%b\n 3:%b\n 4:%b\n 5:%b\n 6:%b\n 7:%b\n 8:%b\n 9:%b\n10:%b\n11:%b\n12:%b\n13:%b\n14:%b\n15:%b\n",
        TCAM.mem[0],
        TCAM.mem[1],
        TCAM.mem[2],
        TCAM.mem[3],
        TCAM.mem[4],
        TCAM.mem[5],
        TCAM.mem[6],
        TCAM.mem[7],
        TCAM.mem[8],
        TCAM.mem[9],
        TCAM.mem[10],
        TCAM.mem[11],
        TCAM.mem[12],
        TCAM.mem[13],
        TCAM.mem[14],
        TCAM.mem[15]);


    #10 we = 0;

    data = 16'b000001010101xx01;
    search = 1;

    #10;

    $display("finding %b: found? %d, mem[%d] = %b", data, found, saddr, sdata);

    data = 16'bx0110101010xx101;

    #10;

    $display("finding %b: found? %d, mem[%d] = %b", data, found, saddr, sdata);

    data = 16'b0011010101111101;

    #10;

    $display("finding %b: found? %d, mem[%d] = %b", data, found, saddr, sdata);
    $stop;
    end
endmodule