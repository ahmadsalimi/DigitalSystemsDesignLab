module sender # (
    parameter START_SIG = 1
) (
    input           rstN,
    input           clk,
    input           start,
    input   [6:0]   data_in,
    output  reg     s_out,
    output  reg     sent
);

localparam S_IDLE       = 0;
localparam S_START      = 1;
localparam S_PARITY     = 2;
localparam S_SEND       = 3;
localparam S_STOP       = 4;

reg [2:0]   state;
reg [6:0]   data;
reg [2:0]   data_index;

wire parity_sig;
assign parity_sig = ^data;

always @(posedge clk or negedge rstN) begin
    if (~rstN) begin
        state <= S_IDLE;
        data_index <= 0;
        s_out <= 0;
        sent <= 0;
    end
    else begin
        case (state)
            S_IDLE: begin
                if (start) begin
                    data_index <= 0;
                    data <= data_in;
                    state <= S_START;
                    sent <= 0;
                end
            end
            S_START: begin
                s_out <= START_SIG;
                state <= S_PARITY;
            end
            S_PARITY: begin
                s_out <= parity_sig;
                state <= S_SEND;
            end
            S_SEND: begin
                s_out <= data[data_index];
                data_index <= data_index + 1;
                if (data_index == 6)
                    state <= S_STOP;
            end
            S_STOP: begin
                s_out <= ~START_SIG;
                state <= S_IDLE;
                sent <= 1;
            end
            default: state <= S_IDLE;
        endcase
    end
end
    
endmodule
