module tcam (
    input           clk,
    input           rstN,
    input           we,
    input   [3:0]   waddr,
    input   [15:0]  data,
    input           search,
    output  [3:0]   saddr,
    output  [15:0]  sdata,
    output          found
);

reg     [15:0]  mem [15:0];
wire    [15:0]  matches;
reg     [3:0]   search_res;

assign saddr = search ? search_res : 4'bx;
assign sdata = search ? mem[search_res] : 16'bx;
assign found = |matches;

genvar i;
generate
    for (i = 0; i < 16; i = i + 1)
        comparator cmp(mem[i], data, matches[i]);
endgenerate

integer j, k;
always @(posedge clk or negedge rstN) begin
    if (~rstN) begin
        for (j = 0; j < 16; j = j + 1)
            mem[j]  = 0;
        search_res = 0;
    end
    else if (we)
        mem[waddr] = data;
    else begin
        search_res = 4'bx;
        if (search && found)
            for (k = 0; search_res === 4'bx && k < 16; k = k + 1)
                if (matches[k]) search_res = k;
    end 
end
    
endmodule