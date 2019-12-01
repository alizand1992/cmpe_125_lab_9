module flop (
    input            clk,
    input            rst, 
    input            [7:0] d,  
    output    reg [7:0] q); 
    
    always@ (posedge clk)
        if   (rst) 
            q <= 8'b0;
        else       
            q <= d;
endmodule