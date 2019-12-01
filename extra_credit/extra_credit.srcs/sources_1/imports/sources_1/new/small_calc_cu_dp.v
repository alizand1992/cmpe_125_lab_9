module CU_DP(
        input go, clk, rst,
        input [1:0] op,
        input [3:0] in1, in2,
        output done,
        output [3:0] out,
        output [3:0] cs
    );
    
    wire we, rea, reb, s2, clk_db;
    wire [1:0] s1, wa, raa, rab, c;
    
    CU CTRL (
        .go(go), .clk(clk), .rst(rst), .op(op), .s1(s1), 
        .wa(wa), .raa(raa), .rab(rab), .c(c), .we(we), .rea(rea), 
        .reb(reb), .s2(s2), .done(done), .cs(cs)
    );
    
    small_calculator_dp DP (
        .clk(clk), .in1(in1), .in2(in2), .s1(s1), .wa(wa), .raa(raa), 
        .rab(rab), .c(c), .we(we), .rea(rea), .reb(reb), .s2(s2), .out(out)
    );
    
endmodule
