module full_calc_cu(
    input go, clk, rst,
    input [2:0] f,
    input done_calc, done_div,
    
    output en_f, en_x, en_y, go_calc, go_div, sel_h, done,
    output en_out_h, en_out_l,
    output [1:0] sel_l,
    output y_sel, x_sel,
    output [1:0] op_calc,
    output reg [3:0] cs
);

    reg [3:0] ns;
    reg [14:0] controls;
    reg [1:0] mul_counter;
    
    assign { op_calc, sel_l, en_f, en_x, en_y, go_calc, go_div, sel_h, en_out_h, en_out_l, y_sel, x_sel, done } = controls;

    always @ (posedge clk, posedge rst)
    begin
        if (rst) begin
            cs = 0;
            ns = 0;
            mul_counter = 3;
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
                        3'b000: ns = 3; // A + B 
                        3'b001: ns = 4; // A - B
                        3'b010: ns = 5; // A * B
                        3'b011: ns = 6; // A / B
                        3'b100: ns = 7; // A++
                        3'b101: ns = 8; // A--
                        3'b110: ns = 9; // B * B
                        3'b111: ns = 0;
                    endcase;    
                end

                4'b0011: 
                begin
                    controls = 15'b00_10_0_0_0_1_0_0_1_1_1_1_0;
                    ns = 11;
                end

                4'b0100: 
                begin 
                    controls = 15'b01_10_0_0_0_1_0_0_1_1_1_1_0;
                    ns = 11;
                end
                
                4'b0101: 
                begin
                    controls = 15'b00_01_0_0_0_0_0_1_1_1_1_1_0;
                    ns = 13;
                end    
                
                4'b0110: 
                begin
                    controls = 15'b00_00_0_0_0_0_1_0_1_1_1_1_0;
                    ns = 12;    
                end
                
                4'b0111: 
                begin
                    controls = 15'b00_10_0_0_0_1_0_0_1_1_0_1_0;
                    ns = 11;
                end
                    
                4'b1000: 
                begin
                    controls = 15'b01_10_0_0_0_1_0_0_1_1_0_1_0;
                    ns = 11;
                end
                
                4'b1001: 
                begin
                    controls = 15'b00_01_0_0_0_0_0_1_1_1_1_0_0;
                    ns = 13;    
                end
                
                4'b1010: 
                begin
                    controls = 15'b00_00_0_0_0_0_0_0_0_0_0_0_1;
                    ns = 0;
                end
                
                4'b1011:
                begin
                    if (done_calc == 0) ns = 11;
                    else                ns = 10;
                end
                
                4'b1100:
                begin
                    if (done_div == 0) ns = 12;
                    else               ns = 10;
                end

                4'b1101:
                begin
                    if (mul_counter == 0) ns = 10;
                    else 
                    begin
                        mul_counter = mul_counter - 1;
                        ns = 13;
                    end
                end
            endcase
        end
    end
endmodule
