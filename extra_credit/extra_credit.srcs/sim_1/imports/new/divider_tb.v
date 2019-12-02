`timescale 1ns / 1ps

module divider_tb();

    reg        go;
    reg        rst;
    reg        clk;
    reg  [3:0] dividend;
    reg  [3:0] divisor;
    wire       done;
    wire       err;
    wire [3:0] q;
    wire [3:0] r;
    wire [2:0] CS;

    integer error;
    integer tb_Dividend;
    integer tb_Divisor;
    
    reg [3:0] exp_q;
    reg [3:0] exp_r;

    task tick;
        begin
            #5 clk = 1;
            #5 clk = 0;
        end
    endtask

    divider DUT (
        .go        (go),
        .rst       (rst),
        .clk       (clk),
        .dividend  (dividend),
        .divisor   (divisor),
        .done      (done),
        .err       (err),
        .q  (q),
        .r (r),
        .CS        (CS)
    );

    initial begin

        error = 0;

        for (tb_Dividend = 0; tb_Dividend < 16; tb_Dividend = tb_Dividend + 1)
        begin
            for (tb_Divisor = 0; tb_Divisor < 16; tb_Divisor = tb_Divisor + 1)
            begin
                rst = 1;
                tick;

                dividend = tb_Dividend;
                divisor = tb_Divisor;
                exp_r = tb_Dividend % tb_Divisor;
                exp_q  = tb_Dividend / tb_Divisor;

                rst = 0;
                go = 1;
                tick;
                go = 0;

                while (!done)
                begin
                    tick;
                end

                
                if((divisor == 0) & (!err))
                begin
                 error = error + 1;
                 end
                else if ((divisor != 0) & (err))  
                 begin
                    error = error + 1;
                 end
                else if (divisor != 0)
                begin
                    if (exp_r != q)
                    begin 
                        error = error + 1;
                    end
                    if (exp_q != q)   
                    begin
                    error = error + 1;
                    end
                end
            end
        end

        if (error == 0) 
            begin
            $display("Success!");
            end
        else
            begin   
                $display("There were %d errors in the simulation.", error);
            end
        $finish;

    end

endmodule
