module small_calc_dp_tb();
    reg clk;
    reg [3:0] in1, in2;
    reg [1:0] s1, wa, raa, rab, c;
    reg we, rea, reb, s2;
    
    wire [3:0] out;
    
    small_calculator_dp DUT (
        .clk(clk),
        .in1(in1),
        .in2(in2),
        .s1(s1), 
        .wa(wa), 
        .raa(raa), 
        .rab(rab), 
        .c(c), 
        .we(we),
        .rea(rea),
        .reb(reb),
        .s2(s2),
        .out(out)
    );
    
    integer i, j, k;
    
    initial
    begin
        clk = 0;

        // Loop to test multiple values
        for (i = 0; i < 5; i = i + 1) begin        
            // Initialize
            we = 1;
            wa = 1;
            s1 = 0;
            s2 = 0;
            #2;
            wa = 2;
            #2;
            
            // Set in1 and 2 to random numbers
            in1 = $random;
            in2 = $random;
            
            wa = 1; // set write address to 1 
            s1 = 1; // set mux to pass through in1
            #2; 
             
            wa = 2; // set the write address 2 
            s1 = 2; // set mux to pass through in2
            #2;
        
            we = 0; // disable write
        
            // Set read address a and b to read from 1 and 2 (where in1 and in2 will be stored at)
            raa = 1;
            rab = 2;
            #2;
            
            // Set read enable for a and b to prepare for ALU
            rea = 1;
            reb = 1;
            #2;
            
            // set s2 to output ALU value
            s2 = 1;
            // change between ALU functions
            //   0 = +
            //   1 = -
            //   2 = &
            //   3 = ^ 
            for (j = 0; j < 4; j = j + 1)
            begin
                c = j;
                #2;
            end
        end
        
        $finish;
    end

    always
        clk = #1 ~clk;
endmodule
