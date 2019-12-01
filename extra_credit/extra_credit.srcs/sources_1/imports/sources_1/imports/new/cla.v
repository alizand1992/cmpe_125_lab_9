module cla(input [3:0] a, input [3:0] b, input cin, output wire [3:0] sum, output wire cout);
    
    wire [4:0] G, P, C;
    
    half_adder ha (.a({a[3:0]}), .b({b[3:0]}));
    assign P = ha.sum;
    assign G = ha.cout;
    
    assign C[0] = cin;
    assign C[1] = G[0] | (P[0] & C[0]);                         //level 2
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) |(P[3] & P[2] & P[1] & P[0] & C[0]);

    assign sum = (P ^ C[3:0]); //Xor                         level 3
    assign cout = C[4];
endmodule
