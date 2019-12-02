module full_calc_dp_tb;
    reg clk, go_calc, go_div, rst, sel_h;
    reg [1:0] op_calc, sel_l;
    reg [3:0] x, y;
    reg y_sel, x_sel;
       
    wire done_calc, done_div;
    wire [3:0] out_h, out_l;
    wire err;
    
    wire [3:0] calc_cs;
    wire [2:0] div_cs;

    full_calc_dp DUT(
        .go_calc(go_calc), .go_div(go_div), .rst(rst), .clk(clk), .x_sel(x_sel), .y_sel(y_sel),
        .x_raw(x), .y_raw(y), 
        .op_calc(op_calc),
        .sel_h(sel_h), .sel_l(sel_l), 
        .done_calc(done_calc), .done_div(done_div), .err(err),
        .out_h(out_h), .out_l(out_l), .calc_cs(calc_cs), .div_cs(div_cs)
    );

    initial begin
        // General Setup
        clk = 0;
        rst = 0;
        go_calc = 0;
        go_div = 0;  
        x_sel = 1;
        y_sel = 1;      
        
        // Setup for the calculator
        go_calc = 1'b1;        
        sel_h = 1'b0;
        sel_l = 2'b10;
        
        // input values
        x = $random;
        y = $random;
                
        // Add
        op_calc = 2'b00;
        #12;

        // input values
        x = $random;
        y = $random;
        
        // Subtract
        op_calc = 2'b01;
        go_calc = 0;
        #2;
        go_calc = 1;
        #14;
      
        
        // turn of calc and move on to other test
        go_calc = 0;

        // input values
        x = $random;
        y = $random;
                
        // multiple
        sel_h = 1;
        sel_l = 1;
        #20;        
        
        
        // divode
        x = $random;
        y = $random;
        sel_l = 0;
        sel_h = 0; 
        go_div = 1;
        #20;
        go_div = 0;   
           
        // X + 1
        x = $random;
        x_sel = 1;
        y_sel = 0;
        go_calc = 1;
        sel_h = 1'b0;
        sel_l = 2'b10;
        op_calc = 2'b00;
        #14;
        
        // X - 1
        x = $random;
        x_sel = 1;
        y_sel = 0;
        op_calc = 2'b01;
        #14;

        // Y * Y
        y = $random;
        x_sel = 0;
        y_sel = 1;
        sel_h = 1;
        sel_l = 1;
        #14;

        $finish;
    end

    always
        clk = #1 ~clk;
endmodule
