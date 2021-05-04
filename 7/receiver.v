module receiver # (
    parameter START_SIG = 1
) (
    input               rstN,
    input               clk,
    input               s_in,
    output  reg         received,
    output              check_parity,
    output  reg [6:0]   data
);

localparam S_IDLE       = 0;
localparam S_PARITY     = 1;
localparam S_RECEIVE    = 2;
localparam S_STOP       = 3;

reg [1:0]   state;
reg [2:0]   data_index;
reg         expected_parity;
wire        actual_parity;

assign actual_parity = ^data;
assign check_parity = actual_parity == expected_parity;

always @(posedge clk or negedge rstN) begin
    if (~rstN) begin
        state <= S_IDLE;
        data_index <= 0;
        received <= 0;
        data <= 0;
    end
    else begin
        case (state)
            S_IDLE: begin
                if (s_in == START_SIG) begin
                    data_index <= 0;
                    data <= 0;
                    state <= S_PARITY;
                    received <= 0;
                end
            end
            S_PARITY: begin
                expected_parity <= s_in;
                state <= S_RECEIVE;
            end
            S_RECEIVE: begin
                data[data_index] <= s_in;
                data_index <= data_index + 1;
                if (data_index == 6) begin
                    state <= S_STOP;
                end
            end
            S_STOP: begin
                state <= S_IDLE;
                received <= 1;
            end
            default: state <= S_IDLE;
        endcase
    end
end

endmodule