module full_calc_cu(
    input go, clk, rst,
    input [2:0] f,
    
    output en_f, en_x, en_y, go_calc, go_div, sel_h,
    output en_out_h, en_out_l,
    output [1:0] sel_l,
    output y_sel, x_sel,
    output [1:0] op_calc
);

    reg [3:0] cs, ns;
    reg [14:0] controls;
    assign { op_calc, sel_l, en_f, en_x, en_y, go_calc, go_div, sel_h, en_out_h, en_out_l, y_sel, x_sel, done } = controls;

    always @ (posedge clk, posedge rst)
    begin
        if (rst) begin
            cs = 0;
            ns = 0;
        end
        else begin
            cs = ns;
            case (cs) 
                4'b0000: 
                begin 
                    controls = 15'b00_00_0_0_0_0_0_0_0_0_0_0_0;
                    ns = 1;    
                end
                4'b0001: 
                begin
                    controls = 15'b00_00_1_1_1_0_0_0_0_0_0_0_0;
                    ns = 2;
                end
                4'b0010: 
                begin
                    controls = 15'b00_00_0_0_0_0_0_0_0_0_0_0_0;
                    case (f) 
                        3'b000: ns = 3; 
                        3'b001: ns = 4;
                        3'b010: ns = 5;
                        3'b011: ns = 6;
                        3'b100: ns = 7;
                        3'b101: ns = 8;
                        3'b110: ns = 9;
                        3'b111: ns = 0;
                    endcase;    
                end
                4'b0011: controls = 15'b00_10_0_0_0_1_0_0_1_1_1_1_0;
                4'b0100: controls = 15'b01_10_0_0_0_1_0_0_1_1_1_1_0;
                4'b0101: controls = 15'b00_01_0_0_0_0_0_1_1_1_0_0_0;
                4'b0110: controls = 15'b00_00_0_0_0_0_1_0_1_1_0_0_0;
                4'b0111: controls = 15'b00_10_0_0_0_1_0_0_1_1_0_1_0;
                4'b1000: controls = 15'b01_10_0_0_0_1_0_0_1_1_0_1_0;
                4'b1001: controls = 15'b00_00_0_0_0_0_0_0_1_1_1_0_0;
                4'b1010: controls = 15'b00_00_0_0_0_0_0_0_0_0_0_0_1;
            endcase
        end
    end
endmodule
