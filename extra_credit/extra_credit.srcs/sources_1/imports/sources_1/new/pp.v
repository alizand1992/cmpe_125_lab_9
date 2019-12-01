module pp(input wire [3:0] a, input wire b, input wire [1:0] shift, output reg [7:0] out);
    always@(*)
    begin
        out = {a[3] & b, a[2] & b, a[1] & b, a[0] & b};
        case(shift)
            2'b00: out = out;
            2'b01: out = out << 1;
            2'b10: out = out << 2;
            3'b11: out = out << 3; 
        endcase
    end
endmodule
