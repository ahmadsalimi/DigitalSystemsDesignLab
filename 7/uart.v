module uart #(
    parameter START_SIG = 1
) (
    input           rstN,
    input           clk,
    input           s_in,
    input           send,
    input   [6:0]   send_data,
    output          s_out,
    output          sent,
    output          received,
    output  [6:0]   received_data,
    output          check_receive_parity
);

sender #(START_SIG) SENDER (rstN, clk, send, send_data, s_out, sent);
receiver #(START_SIG) RECEIVER (rstN, clk, s_in, received, check_receive_parity, received_data);
    
endmodule