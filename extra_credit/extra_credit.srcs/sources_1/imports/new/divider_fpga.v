`timescale 1ns / 1ps

module divider_fpga(
    input        go,
    input        rst,
    input        clk100MHz,
    input        debounce_clk,
    input  [3:0] dividend,
    input  [3:0] divisor,
    output       done,
    output       err,
    output [3:0] LEDSEL,
    output [7:0] LEDOUT
    );
    supply1 [7:0] vcc;
    wire DONT_USE;
    wire clk_5KHz;
    wire debounce;

    wire [3:0] q;
    wire [3:0] r;
    wire [2:0] CS;
    wire [3:0] onesR;
    wire [3:0] tensR;
    wire [3:0] onesQ;
    wire [3:0] tensQ;
    wire [7:0] Q_led;
    wire [7:0] Q_led1;
    wire [7:0] R_led;
    wire [7:0] R_led1;
    clk_gen CLK(clk100MHz, rst, DONT_USE, clk_5KHz);   
    button_debouncer but(clk_5KHz, debounce_clk, debounce);
    divider d(
    .go         (go),
    .rst        (rst),
    .clk        (debounce),
    .dividend   (dividend),
    .divisor    (divisor),
    .done       (done),
    .err        (err),
    .CS         (CS),
    .q   (q),
    .r  (r)
    );
    
    split s(
    .value (r),
    .ones (onesR),
    .tens (tensR)
    );
    split s1(
    .value (q),
    .ones (onesQ),
    .tens (tensQ)
    );
    bcd_to_7seg(onesQ, Q_led1);
    bcd_to_7seg(tensQ, Q_led);
    bcd_to_7seg(tensR, R_led);
    bcd_to_7seg(onesR, R_led1);
    
    led_mux LED(clk_5KHz, rst, Q_led, Q_led1, R_led, R_led1,
    LEDSEL, LEDOUT);

endmodule

module split(
  input  wire [3:0] value, 
  output wire [3:0] ones, 
  output wire [3:0] tens
  );
  
  assign ones = value % 10;
  assign tens = (value / 10)%10;
endmodule