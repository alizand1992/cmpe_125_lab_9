module multiplier(input [3:0] a, b, input clk, rst, output reg [7:0] out);

    wire [7:0] w_pp1;
    wire [7:0] w_pp2;
    wire [7:0] w_pp3;
    wire [7:0] w_pp4;
    
    wire [7:0] w_cla1;
    wire [7:0] w_cla2;
    wire [7:0] w_cla3;

    reg [7:0] r_pp1;
    reg [7:0] r_pp2;
    reg [7:0] r_pp3;
    reg [7:0] r_pp4;
    
    reg [7:0] r_cla1;
    reg [7:0] r_cla2;
    
    wire [7:0] w_f1;
    wire [7:0] w_f2;
    wire [7:0] w_f3;
    wire [7:0] w_f4;
    wire [7:0] w_f5;
    wire [7:0] w_f6;
    wire [7:0] w_f7;
    
    flop f1(.clk(clk), .rst(rst), .d(w_pp1), .q(w_f1));
    flop f2(.clk(clk), .rst(rst), .d(w_pp2), .q(w_f2));
    flop f3(.clk(clk), .rst(rst), .d(w_pp3), .q(w_f3));
    flop f4(.clk(clk), .rst(rst), .d(w_pp4), .q(w_f4));

    flop f5(.clk(clk), .rst(rst), .d(w_cla1), .q(w_f5));
    flop f6(.clk(clk), .rst(rst), .d(w_cla2), .q(w_f6));

    flop f7(.clk(clk), .rst(rst), .d(w_cla3), .q(w_f7));

    pp pp1(.a(a), .b(b[0]), .shift(2'b00), .out(w_pp1));
    pp pp2(.a(a), .b(b[1]), .shift(2'b01), .out(w_pp2));
    pp pp3(.a(a), .b(b[2]), .shift(2'b10), .out(w_pp3));
    pp pp4(.a(a), .b(b[3]), .shift(2'b11), .out(w_pp4));
    
    cla8 cla1 (.a(w_pp1), .b(w_pp2), .cin(1'b0), .sum(w_cla1));
    cla8 cla2 (.a(w_pp4), .b(w_pp3), .cin(1'b0), .sum(w_cla2));
    cla8 cla3 (.a(cla1.sum), .b(cla2.sum), .cin(1'b0), .sum(w_cla3));
    
    always@(posedge clk, posedge rst)
    begin
        if (!rst)
        begin
            out = w_f7;
        end
        else
        begin
            out = 0;
        end
    end
endmodule
