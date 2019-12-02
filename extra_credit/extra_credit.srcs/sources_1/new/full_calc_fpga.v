module full_calc_fpga
(
    input clk100MHz, clk_btn, rst, go,
    input [3:0] x, y,
    input [2:0] f,
    
    output done,
    output [7:0] LEDOUT,
    output [3:0] LEDSEL    
);
    wire [3:0] out_h, out_l;
    wire clk, clk_5KHz, DONT_USE;
    
    reg [3:0] val0, val1, val2, val3;
    wire [7:0] led0, led1, led2, led3;
    
    reg [7:0] mul_out;
    
    clk_gen CLK (
        .clk100MHz(clk100MHz), .rst(rst), .clk_4sec(DONT_USE), .clk_5KHz(clk_5KHz)
    );
    
    button_debouncer CLK_DB(
        .clk(clk_5KHz), .button(clk_btn), .debounced_button(clk)
    );
    
    full_calc_cu_dp cudp (
        .x(x), .y(y), .in_f(f), .clk(clk), .go(go),
        .done(done), .out_h(out_h), .out_l(out_l)
    );
    
    bcd_to_7seg LED0 (.BCD(val0), .s(led0));
    bcd_to_7seg LED1 (.BCD(val1), .s(led1));
    bcd_to_7seg LED2 (.BCD(val2), .s(led2));
    bcd_to_7seg LED3 (.BCD(val3), .s(led3));

    led_mux LED_MUX (clk_5KHz, rst, led3, led2, led1, led0, LEDSEL, LEDOUT);
    
    always @ (posedge clk)
    begin
        if (f == 2 || f == 6) 
        begin
            mul_out = {out_h, out_l};
            val0 = mul_out % 10;
            val1 = (mul_out / 10) % 10;
            val1 = (mul_out / 100) % 10;
            val1 = (mul_out / 1000) % 10;
        end
    end
    
endmodule
