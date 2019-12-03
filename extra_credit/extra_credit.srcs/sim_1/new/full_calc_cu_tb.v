module full_calc_cu_tb;
    reg clk, go, rst;
    reg [2:0] f; 
    
    wire done;
    wire [3:0] cs;
    reg done_calc, done_div;
    
    full_calc_cu DUT (
        .clk(clk), .go(go), .f(f), .rst(rst), .done(done),
        .done_calc(done_calc), .done_div(done_div), .cs(cs)
    );
    
    integer error;
    
    initial
    begin
        clk = 0;
        rst = 0;
        #2;
        rst = 1;
        #2;
        rst = 0;
        go = 1;
        error = 0;
        done_div = 0;
       
        
        f = 3'b000; // Add
        done_calc = 0;
        
        #10
        if(cs != 11)
            error = error + 1;
            
        done_calc = 1;
        #10
        
        if (cs != 10)
            error = error + 1;

        f = 3'b001; // Sub
        done_calc = 0;
        
        #10
        if(cs != 11)
            error = error + 1;
            
        done_calc = 1;
        #10
        
        if (cs != 10)
            error = error + 1;
            
        f = 3'b010; // multi
        
        #6;
        if(cs != 13)
            error = error + 1;
            
        #2;
        
        if (cs != 10)
            error = error + 1;
            
        f = 3'b011; // Div
        done_div = 0;
        
        #10
        if(cs != 12)
            error = error + 1;
            
        done_div = 1;
        #10
        
        if (cs != 10)
            error = error + 1;
            
        f = 3'b100; // A++
        done_calc = 0;
        
        #10
        if(cs != 11)
            error = error + 1;
            
        done_calc = 1;
        #10
        
        if (cs != 10)
            error = error + 1;
            
        f = 3'b101; // A--
        done_calc = 0;
        
        #10
        if(cs != 11)
            error = error + 1;
            
        done_calc = 1;
        #10
        
        if (cs != 10)
            error = error + 1;
            
        f = 3'b111; // Add
        done_calc = 0;
         #10
        if (cs != 0)
            error = error + 1;




            
        


            
        $finish;
                 
    end    
    
    always
    begin
        clk = #1 ~clk;
    end

endmodule
