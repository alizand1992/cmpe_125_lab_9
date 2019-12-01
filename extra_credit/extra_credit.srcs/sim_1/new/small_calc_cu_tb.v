module small_calc_cu_tb;
    reg clk, go;
    reg [3:0] in1, in2;
    reg [1:0] op;
    
    wire [3:0] cs, out;
    wire done;
    
    small_calc_cu_dp DUT (
        .clk(clk), .go(go), .in1(in1), .in2(in2),
        .op(op), .cs(cs), .out(out), .done(done)    
    );
    
    integer i, j, k;
    
    initial
    begin
        clk = 0;
        go = 1;

        in1 = $random;
                
        in2 = $random;
        
        for (k = 0; k < 4; k = k + 1)
        begin
            op = k;
            #20;
        end
        $finish;                 
    end    
    
    always
    begin
        clk = #1 ~clk;
    end

endmodule
