module full_calc_cu_dp(
    input [3:0] x, y,
    input [2:0] in_f,
    input clk, go,
    
    output done, 
    output [3:0] out_h, out_l
);

    wire en_f, en_x, en_y, go_calc, go_div, x_sel, y_sel, rst, sel_h;
    wire done_calc, done_div, err, en_out_h, en_out_l;
    wire [3:0] x_raw, y_raw, m_out_h, m_out_l;
    wire [2:0] f; 
    wire [1:0] op_calc, sel_l;
    
    en_flop xreg(.clk(clk), .en(en_x), .in(x), .out(x_raw));
    en_flop yreg(.clk(clk), .en(en_y), .in(y), .out(y_raw));
    en_flop #(3) freg(.clk(clk), .en(en_f), .in(in_f), .out(f));

    en_flop ohreg(.clk(clk), .en(en_out_h), .in(m_out_h), .out(out_h));
    en_flop olreg(.clk(clk), .en(en_out_l), .in(m_out_l), .out(out_l));
    
    full_calc_dp dp(
        .go_calc(go_calc), .go_div(go_div), .rst(rst), .clk(clk), .x_sel(x_sel), .y_sel(y_sel), 
        .x_raw(x_raw), .y_raw(y_raw),
        .op_calc(op_calc), .sel_l(sel_l), .sel_h(sel_h), 
        .done_calc(done_calc), .done_div(done_div), .err(err), .out_h(m_out_h), .out_l(m_out_l)
    );
    
    full_calc_cu cu(
        .go(go), .clk(clk), .f(f), 
        
        .en_f(en_f), .en_x(en_x), .en_y(en_y), .go_calc(go_calc), .go_div(go_div), 
        .en_out_h(en_out_h), .en_out_l(en_out_l),
        .set_h(set_h), .set_l(set_l), .y_sel(y_sel), .x_sel(x_sel), .op_calc(op_calc)
    );   
endmodule
