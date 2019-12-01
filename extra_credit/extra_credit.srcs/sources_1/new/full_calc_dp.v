module full_calc_dp(
    input go_calc, go_div, rst, clk,
    input [3:0] x, y,
    input [1:0] op_calc,
    
    input sel_h,
    input [1:0] sel_l,
    
    output done_calc, done_div, err,
    output [3:0] out_h,
    output [3:0] out_l,
    output [3:0] calc_cs
);

    wire [2:0] cs;
//    wire [3:0] calc_cs;    
    wire [7:0] mul_out;
    wire [3:0] calc_out, q, r;
    
    wire[3:0] ph, pl;
    
    divider d(
        .go(go_div), .rst(rst), .clk(clk), .dividend(x), .divisor(y), 
        .done(done_div), .err(err), .q(q), .r(r), .CS(cs)
    );
    
    multiplier m(
        .a(x), .b(y), .clk(clk), .rst(rst), .out(mul_out)
    );
    
    small_calc_cu_dp sc(
        .go(go_calc), .rst(rst), .clk(clk), .op(op_calc), .in1(x), .in2(y),
        .done(done_calc), .out(calc_out), .cs(calc_cs)
    );
  
    assign {ph, pl} = mul_out; 
  
    mux2 mux_h (.in0(ph), .in1(r), .sel(sel_h), .out(out_h));
    mux4 mux_l (.in0(q), .in1(pl), .in2(calc_out), .in3(0), .out(out_l), .sel(sel_l));
        
//    register_file rf(
endmodule
