module small_calc_cu_dp(
    input clk, go, rst,
    input [3:0] in1, in2,
    input [1:0] op,
    
    output reg [3:0] cs,
    output wire [3:0] out,
    output wire done
);
    
    wire [1:0] s1, wa, raa, rab, c;
    wire we, rea, reb, s2;
    
    reg [3:0] ns;
        
    small_calc_cu cu (
        .clk(clk), .op(op), .cs(cs),
        .s1(s1), .wa(wa), .raa(raa), .rab(rab), .c(c),
        .we(we), .rea(rea), .reb(reb), .s2(s2), .done(done)
    );
    
    small_calculator_dp scdp (
        .clk(clk), .in1(in1), .in2(in2), .s1(s1), .wa(wa),
        .raa(raa), .rab(rab), .c(c), .we(we), .rea(rea),
        .reb(reb), .s2(s2), .out(out)
    );

    always @ (go, op, cs) 
    begin
        case(cs)
            4'b0:
                if (!go) ns = 0;
                else ns = 1;
            4'b0001:
                ns = 2;
            4'b0010:
                ns = 3;
            4'b0011:
                ns = 4;
            4'b0100:
                ns = 0;
            default:
                ns = 0;
        endcase
    end
    
    always @ (posedge clk, posedge rst) 
    begin
        if (rst) cs <= 0;
        else cs <= ns;
    end
endmodule
