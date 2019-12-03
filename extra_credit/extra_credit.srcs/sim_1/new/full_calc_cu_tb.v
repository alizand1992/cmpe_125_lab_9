
module full_calc_cu_tb;
    reg clk, go, rst;
    reg [2:0] f; 
    
    wire done;
    reg done_calc, done_div;
    
    full_calc_cu DUT (
        .clk(clk), .go(go), .f(f), .rst(rst), .done(done),
        .done_calc(done_calc), .done_div(done_div)
    );
    
    reg [3:0] cs, ns;
    integer i, j, k;
    integer error;
    
    initial
    begin
        clk = 0;
        rst = 0;
        go = 1;
        cs = 0;
        f = 1;
        error = 0;
       
        
        f = 3'b000;
        done_calc = 0;
        
        #10
        if(cs != 11)
            error = error + 1;
        done_calc = 1;
        #2
        
        if (cs != 10)
            error = error + 1;
            
        $finish;
                 
    end    
    
    always
    begin
        clk = #1 ~clk;
    end

endmodule
