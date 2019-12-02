
module full_calc_cu_tb;
    reg clk, go, rst;
    reg [2:0] f; 
    
    wire done;
    wire done_calc, done_div;
    
    full_calc_cu DUT (
        .clk(clk), .go(go), .f(f), .rst(rst), .done(done),
        .done_calc(done_calc), .done_div(done_div)
    );
    
    reg [3:0] cs, ns;
    integer i, j, k;
    
    initial
    begin
        clk = 0;
        go = 1;
        cs = 0;
        
        while (!go || rst)
        begin
            cs = 0;
            if (cs != 0)
            begin
                $display ("Error, started at !go");
            end
        end
        for (i = 1; i < 14; i = i + 1)
            begin
            cs = i;
            while (cs ==
                
                 
    end    
    
    always
    begin
        clk = #1 ~clk;
    end

endmodule
