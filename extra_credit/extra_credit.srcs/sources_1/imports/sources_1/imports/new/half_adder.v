module half_adder(input [3:0] a, b, output [3:0] sum, output [9:0] cout);
    and2 and_1 (.a(a), .b(b));
    xor2 xor_1 (.a(a), .b(b));
    
    assign sum = xor_1.out;
    assign cout = and_1.out;
endmodule
