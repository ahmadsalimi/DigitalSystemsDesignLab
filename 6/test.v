module test ();

reg signed [7:0] sensor;
reg clock = 0;
reg reset = 0;
wire [3:0] rps;
wire heater;
wire cooler;

controller control (sensor, clock, reset, cooler, heater, rps);


initial begin
    $monitor("cooler: %d, heater: %d, rps: %d", cooler, heater, rps);
    clock = 0;
    sensor = 8'd20;
    #20 reset = 1;
    #20 sensor = 8'd40;
    #20 sensor = 8'd20;
    #20 sensor = 8'd20;
    #20 sensor = 8'd8;
    #20 sensor = 8'd33;
    #20 sensor = -8'd5;
    #20 sensor = 8'd46;
    #20 $stop;
end

always
  #10 clock = ~clock;


endmodule // test
