module en_flop #(parameter WIDTH = 4) 
(
    input clk, en, rst,
    input [WIDTH - 1:0] in,
    
    output [WIDTH - 1:0] out
);

    reg [WIDTH - 1:0] mem;
    
    always @ (posedge clk, posedge rst)
    begin
        if (rst) 
            mem = 0;
        else if (en) 
            mem = in;
    end
    
    assign out = mem;
endmodule
