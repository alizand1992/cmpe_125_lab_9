module mux2 #(parameter WIDTH = 4)
    (
    input  [WIDTH - 1:0] d1,
    input  [WIDTH - 1:0] d2,
    input  sel,
    output [WIDTH - 1:0] y
    );

    assign y = sel ? d1: d2;

endmodule
