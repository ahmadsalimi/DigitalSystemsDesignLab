module booth_TB ();

reg signed  [3:0]   A;
reg signed  [3:0]   B;
reg         rstN = 1, clk = 1;
wire signed [7:0]  res;
wire        done;

booth MUL (A, B, rstN, clk, res, done);

always #10 clk = ~clk;

initial begin
    $monitor("res: %b", res);

    #20;
    A = -7;
    B = -5;
    rstN = 0;
    #20 rstN = 1;
    wait (done);

    $display("%d * %d = %d", A, B, res);

    #20;
    A = 4;
    B = 5;
    rstN = 0;
    #20 rstN = 1;
    wait (done);

    $display("%d * %d = %d", A, B, res);
    
    #20;
    A = -3;
    B = 6;
    rstN = 0;
    #20 rstN = 1;
    wait (done);

    $display("%d * %d = %d", A, B, res);
    
    #20;
    A = 7;
    B = -6;
    rstN = 0;
    #20 rstN = 1;
    wait (done);
    
    $display("%d * %d = %d", A, B, res);

    #20;
    
    $stop;
end

endmodule