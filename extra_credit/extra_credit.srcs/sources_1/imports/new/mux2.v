module mux2 #(parameter WIDTH = 4)
    (
    input  [WIDTH - 1:0] in0,
    input  [WIDTH - 1:0] in1,
    input  sel,
    output [WIDTH - 1:0] out
    );

    assign out = sel ? in1 : in0;

endmodule
