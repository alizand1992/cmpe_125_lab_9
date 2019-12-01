module divider_control_unit
(
 input            go, clk, rst, R_lt_Y, cnt_out, divby0,
 output reg       mux1, mux2, mux3, R_LD, R_SL, R_SR, X_LD, X_SL, X_right_in, Y_LD, LD, CE, done, err,
 output reg [2:0] CS
);

   reg [2:0]     NS;
   reg [13:0]    signal_out;

   //state regsiter
   always @ (posedge clk, posedge rst)
     begin
        if (rst)
          begin
             CS <= 0;
          end
        else
          begin
             CS <= NS;
          end
     end

   always @ (signal_out)
     begin
        {mux1,mux2,mux3, CE, LD, R_SR, R_SL, R_LD, X_SL, X_LD, X_right_in, Y_LD, done, err} = signal_out;
     end

   always @ (CS, go, divby0)
     begin
        case (CS)
          0:  begin
             if (go) NS = 1;
             else    NS = 0;
          end
          1: NS = 2;
          2:  begin
             if (divby0) NS = 7;
             else     NS = 3;
          end
          3:  begin
             if (R_lt_Y) NS = 5;
             else        NS = 4;
          end
          4:  begin
             if (cnt_out) NS = 6;
             else         NS = 3;
          end
          5:  begin
             if (cnt_out) NS = 6;
             else         NS = 3;
          end
          6: NS = 7;
          7: NS = 0;
          default: NS = 0;
        endcase
     end

   always @ (CS)
     begin
        case (CS)
          0: signal_out = 14'b00000000000000;
          1: signal_out = 14'b00011001010100;
          2: signal_out = 14'b00000010100000;
          3:  begin
             if (R_lt_Y) signal_out = 14'b00010000000000;
             else        signal_out = 14'b10010001000000;
          end
          4: signal_out = 14'b00000010101000;
          5: signal_out = 14'b00000010100000;
          6: signal_out = 14'b00000100000000;
          7:  begin
             if (divby0) signal_out = 14'b00000000000011;
             else     signal_out = 14'b01100000000010;
          end
        endcase
     end
endmodule
