module full_calc_dp_tb;
    reg clk, go_calc, go_div, rst, sel_h;
    reg [1:0] op_calc, sel_l;
    reg [3:0] x, y;
       
    wire done_calc, done_div;
    wire [3:0] out_h, out_l;
    wire err;

    full_calc_dp fcdp(
        .go_calc(go_calc), .go_div(go_div), .rst(rst), .clk(clk), 
        .x(x), .y(y), 
        .op_calc(op_calc),
        .sel_h(sel_h), .sel_l(sel_l), 
        .done_calc(done_calc), .done_div(done_div), .err(err),
        .out_h(out_h), .out_l(out_l) 
    );

    initial begin
        clk = 0;
        rst = 0;
        #2;
        op_calc = 2'b01;
        sel_l = 2'b10;
        
        #2;
        
        x = 4;
        y = 3;
        
        #2;
        
        go_calc = 1'b1;
        #10;
        
        $finish;
    end

    always
        clk = #1 ~clk;
endmodule
