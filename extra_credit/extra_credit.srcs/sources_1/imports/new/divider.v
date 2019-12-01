module divider
(
 input go, rst, clk,
 input [3:0] dividend, divisor,
 output done, err,
 output [3:0] q, r,
 output [2:0] CS
);

   wire       mux1;
   wire       mux2;
   wire       mux3;
   wire       R_LD;
   wire       R_SL;
   wire       R_SR;
   wire       X_LD;
   wire       X_SL;
   wire       X_right_in;
   wire       Y_LD;
   wire       LD;
   wire       CE;

   wire       R_lt_Y;
   wire       cnt_out;
   wire       divby0;


    divider_data_path data_path
      (
       .dividend(dividend), .divisor(divisor), .n(4), .clk(clk),
       .rst(rst), .mux1(mux1), .mux2(mux2), .mux3(mux3), .R_LD(R_LD),
       .R_SL(R_SL), .R_SR(R_SR), .X_LD(X_LD), .X_SL(X_SL),
       .X_right_in(X_right_in), .Y_LD(Y_LD), .LD(LD), .CE(CE),
       .divby0(divby0), .R(r), .Q(q), .R_lt_Y(R_lt_Y), .cnt_out(cnt_out)
      );

    divider_control_unit control
      (
       .go(go), .clk(clk), .rst(rst), .R_lt_Y(R_lt_Y), .cnt_out(cnt_out),
       .divby0(divby0), .mux1(mux1), .mux2(mux2), .mux3(mux3), .R_LD(R_LD),
       .R_SL(R_SL), .R_SR(R_SR), .X_LD(X_LD), .X_SL(X_SL),
       .X_right_in(X_right_in), .Y_LD(Y_LD), .LD(LD), .CE(CE), .done(done),
       .err(err), .CS(CS)
      );

endmodule
