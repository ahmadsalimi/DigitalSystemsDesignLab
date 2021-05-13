module pipeline_TB ();

reg rstN = 0, clk = 1;
pipeline PIPELINE(clk, rstN);

always #10 clk = ~clk;
initial begin
    $readmemb("data/inst_mem.txt", PIPELINE.IF.mem, 0, 32);
    $readmemb("data/initial_mem.txt", PIPELINE.MEM.mem, 0, 32);
    
    #40 rstN = 1;
    wait(PIPELINE.IF.pc == 18);
    $writememb("data/final_mem.txt", PIPELINE.MEM.mem);
    $stop;
end

endmodule
