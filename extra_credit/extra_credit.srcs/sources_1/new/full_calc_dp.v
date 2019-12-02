module full_calc_dp(
    input go_calc, go_div, rst, clk, x_sel, y_sel,
    input [3:0] x_raw, y_raw,
    input [1:0] op_calc,
    
    input sel_h,
    input [1:0] sel_l,
    
    input [3:0] cs,
    
    output done_calc, done_div, err,
    output [3:0] out_h,
    output [3:0] out_l,
    output [3:0] calc_cs,
    output [2:0] div_cs
);

    wire [7:0] mul_out;
    wire [3:0] calc_out, q, r;
    
    wire[3:0] ph, pl;
    
    wire [3:0] x, y;
    
    mux2 x_in (.in0(y_raw), .in1(x_raw), .out(x), .sel(x_sel));
    mux2 y_in (.in0(4'b0001), .in1(y_raw), .out(y), .sel(y_sel));
    
    divider d(
        .go(go_div), .rst(rst), .clk(clk), .dividend(x), .divisor(y), 
        .done(done_div), .err(err), .q(q), .r(r), .CS(div_cs)
    );
    
    multiplier m(
        .a(x), .b(y), .clk(clk), .rst(rst), .out(mul_out)
    );
    
    small_calc_cu_dp sc(
        .go(go_calc), .rst(rst), .clk(clk), .op(op_calc), .in1(x), .in2(y),
        .done(done_calc), .out(calc_out), .cs(calc_cs)
    );
  
    assign {ph, pl} = mul_out; 
  
    mux2 mux_h (.in0(q), .in1(ph), .sel(sel_h), .out(out_h));
    mux4 mux_l (.in0(r), .in1(pl), .in2(calc_out), .in3(0), .out(out_l), .sel(sel_l));
endmodule
