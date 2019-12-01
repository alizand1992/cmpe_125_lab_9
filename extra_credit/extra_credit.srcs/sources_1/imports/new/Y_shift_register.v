module Y_shift_register #(parameter WIDTH = 4)
(
 input [WIDTH - 1:0] D,
 input left_in, right_in, LD, SL, SR, rst, CLK,
 output reg [WIDTH - 1:0] Q,
 output divby0
);

   always @ (posedge CLK, posedge rst)
     begin
        if (rst) Q = 0;
        else
          begin
             if (LD) Q = D;
             else if (SL)
               begin
                  Q[WIDTH - 1:1] = Q[WIDTH - 2:0];
                  Q[0] = right_in;
               end
             else if (SR)
               begin
                  Q[WIDTH - 1] = left_in;
                  Q[WIDTH - 2:0] = Q[WIDTH - 1:1];
               end
             else Q = Q;
          end
     end

    assign divby0 = (Q == 0) ? 1 : 0;

endmodule
