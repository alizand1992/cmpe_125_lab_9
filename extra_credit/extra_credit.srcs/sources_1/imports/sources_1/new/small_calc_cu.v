module small_calc_cu(
    input clk,
    input [1:0] op,
    input [3:0] cs,
    
    output wire [1:0] s1, wa, raa, rab, c,
    output wire we, rea, reb, s2, done
);
    
    reg[14:0] controls;
    
    assign { s1, wa, raa, rab, c, we, rea, reb, s2, done } = controls;

    always @ (posedge clk)
    begin
        case(cs)
            4'b0000: controls <= 15'b00_00_00_00_00_0_0_0_0_0;
            4'b0001: controls <= 15'b01_01_00_00_00_1_0_0_0_0;             
            4'b0010: controls <= 15'b10_10_00_00_00_1_0_0_0_0;
            4'b0011:
                case(op)
                    2'b11: controls <= 15'b11_11_01_10_00_1_1_1_0_0;
                    2'b10: controls <= 15'b11_11_01_10_01_1_1_1_0_0;
                    2'b01: controls <= 15'b11_11_01_10_10_1_1_1_0_0;
                    2'b00: controls <= 15'b11_11_01_10_11_1_1_1_0_0;                    
                endcase
            4'b0100: controls <= 15'b00_00_11_11_10_0_1_1_1_1;
            default: controls <= 15'b00_00_00_00_00_0_0_0_0_0;
        endcase
    end
endmodule
