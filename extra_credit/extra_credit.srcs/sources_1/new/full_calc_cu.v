module full_calc_cu(
    input go,
    input [2:0] f,
    
    output en_f, en_x, en_y, go_calc, go_div, set_h, set_l,
    output reg s1, s2,
    output reg [1:0] op_calc
);

    always @(f)
    begin
        case(f)
            3'b000: { op_calc, s1, s2 } = 4'b00_1_1;
            3'b001: { op_calc, s1, s2 } = 4'b01_1_1;
            3'b010: { op_calc, s1, s2 } = 4'b00_1_1;
            3'b011: { op_calc, s1, s2 } = 4'b00_1_1;
            3'b100: { op_calc, s1, s2 } = 4'b00_0_1;
            3'b101: { op_calc, s1, s2 } = 4'b01_0_1;
            3'b110: { op_calc, s1, s2 } = 4'b00_1_0;
            default: { op_calc, s1, s2 } = 4'b00_0_0;
        endcase
    end
endmodule
