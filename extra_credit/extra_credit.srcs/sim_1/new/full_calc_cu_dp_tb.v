
module full_calc_cu_dp_tb;
    reg clk, go;
    reg [2:0] f; 
    reg [3:0] x, y;
    reg [3:0] out_h, out_l;
    
    wire done;
    wire done_calc, done_div;
    
    full_calc_cu_dp DUT (
        .clk(clk), .go(go), .f(f), .x(x), .y(y),
        .out_h(out_h), .out_l(out_l), .done(done),
        .done_calc(done_calc), .done_div(done_div)
    );
    
    
    integer i, j, k;
    
    initial
    begin
        clk = 0;
        go = 1;

        x = $random;
                
        y = $random;
        
        for (k = 0; k < 8; k = k + 1)
        begin
            f = k;
            #20;
        end
        $finish;                 
    end    
    
    always
    begin
        clk = #1 ~clk;
    end

endmodule
