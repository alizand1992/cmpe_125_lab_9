module cla8(input [7:0] a, b, input cin, output wire [7:0] sum, output wire cout);
    wire cout_right;
    wire [3:0] sum_right;
    wire [3:0] sum_left;
        
    cla cla_right (.a({a[3:0]}), .b({b[3:0]}), .cin(cin), .sum(sum_right), .cout(cout_right));
    cla cla_left (.a({a[7:4]}), .b({b[7:4]}), .cin(cout_right), .sum(sum_left), .cout(cout));
    
    assign sum = {sum_left, sum_right};
endmodule
