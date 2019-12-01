module divider_data_path
(
 input [3:0]  dividend, divisor,
 input [2:0]  n,
 input        clk, rst, mux1, mux2, mux3, R_LD, R_SL, R_SR, X_LD, X_SL, X_right_in, Y_LD, LD, CE,
 output [3:0] R, Q,
 output       R_lt_Y, divby0, cnt_out
);

   wire [4:0] remainder_out;
   wire [3:0] dividend_out;
   wire [3:0] divisor_out;
   wire [4:0] sub_out;
   wire [4:0] R_data;
   wire [2:0] count_out;

   mux2 #(5) input_mux(.d1(sub_out), .d2(0), .sel(mux1), .y(R_data));

   shift_register #(5) R_shifter
     (
      .D(R_data), .left_in(1'b0), .right_in(dividend_out[3]),
      .LD(R_LD), .SL(R_SL), .SR(R_SR), .rst(rst), .CLK(clk),
      .Q(remainder_out)
     );

    shift_register X_shifter
      (
       .D(dividend), .left_in(1'b0), .right_in(X_right_in),
       .LD(X_LD), .SL(X_SL), .SR(0), .rst(rst), .CLK(clk),
       .Q(dividend_out)
      );

   Y_shift_register Y_shifter
     (
      .D(divisor), .left_in(1'b0), .right_in(1'b0), .LD(Y_LD),
      .SL(0), .SR(0), .rst(rst), .CLK(clk), .Q(divisor_out),
      .divby0(divby0)
    );

   comparator comp(.a(remainder_out), .b({1'b0, divisor_out}), .lt(R_lt_Y));

   subtractor sub(.a(remainder_out), .b({1'b0, divisor_out}), .c(sub_out));

   ud_counter count
     (
      .D(n), .LD(LD), .UD(0), .CE(CE), .rst(rst), .CLK(clk),
      .Q(count_out), .cnt_out(cnt_out)
     );

   mux2 r_mux(.d1(remainder_out[3:0]), .d2(0), .sel(mux2), .y(R));

   mux2 q_mux (.d1(dividend_out), .d2(0), .sel(mux3), .y(Q));
endmodule
