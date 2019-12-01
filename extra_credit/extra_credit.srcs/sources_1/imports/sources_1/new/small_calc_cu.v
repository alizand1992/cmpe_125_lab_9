module CU (
        input wire go, clk, rst,
        input wire [1:0] op,
        output reg [1:0] s1, wa, raa, rab, c,
        output reg we, rea, reb, s2, done,
        output reg [3:0] cs                    //current state
);

    reg [3:0] ns;

    always @ (rst)
    begin 
        cs = 0;                    //current state = 0
    end
    
    always @ (posedge clk) 
    begin
        cs = ns;
    end    
    
    always @ (cs, go, op)          //state machine logic
    begin
    case(cs)
        4'b0: 
            if(!go) 
                ns = 4'b0;
            else 
                ns = 4'b0001;
        4'b0001: 
            ns = 4'b0010;
        4'b0010:
            ns = 4'b0011;
        4'b0011: 
            if(op == 2'b00) // xor
                ns = 4'b0100;
            else if(op == 2'b11) // and
                ns = 4'b0101;
            else if(op == 2'b10) // subtract
                ns = 4'b0110;
            else if(op == 2'b01) // add
                ns = 4'b0111;
        4'b0100: 
            ns = 4'b1000;
        4'b0101: 
            ns = 4'b1000;
        4'b0110: 
            ns = 4'b1000;
        4'b0111: 
            ns = 4'b1000;
        4'b1000:
            ns = 4'b0;
        default:
            ns = 4'b0;
    endcase
    end
        
    always @ (cs)
    begin
    case(cs)
        4'b0: 
        begin
            s1 = 1;
            wa = 0;
            we = 0;
            raa = 0;
            rea = 0;
            rab = 0;
            reb = 0;
            c = 0;
            s2 = 0;
            done = 0;
        end
        4'b0001: 
        begin
            s1 = 3;
            wa = 1;
            we = 1;
            raa = 0;
            rea = 0;
            rab = 0;
            reb = 0;
            c = 0;
            s2 = 0;
            done = 0;
        end
        4'b0010: 
        begin
            s1 = 2;
            wa = 2;
            we = 1;
            raa = 0;
            rea = 0;
            rab = 0;
            reb = 0;
            c = 0;
            s2 = 0;
            done = 0;
        end
        4'b0011: 
        begin
            s1 = 1;
            wa = 0;
            we = 0;
            raa = 0;
            rea = 0;
            rab = 0;
            reb = 0;
            c = 0;
            s2 = 0;
            done = 0;
        end
        4'b0100: 
        begin
            s1 = 0;
            wa = 3;
            we = 1;
            raa = 1;
            rea = 1;
            rab = 2;
            reb = 1;
            c = 0;
            s2 = 0;
            done = 0;
        end
        4'b0101:
        begin
            s1 = 0;
            wa = 3;
            we = 1;
            raa = 1;
            rea = 1;
            rab = 2;
            reb = 1;
            c = 1;
            s2 = 0;
            done = 0;
        end
        4'b0110:
        begin
            s1 = 0;
            wa = 3;
            we = 1;
            raa = 1;
            rea = 1;
            rab = 2;
            reb = 1;
            c = 2;
            s2 = 0;
            done = 0;
        end
        4'b0111: 
        begin
            s1 = 0;
            wa = 3;
            we = 1;
            raa = 1;
            rea = 1;
            rab = 2;
            reb = 1;
            c = 3;
            s2 = 0;
            done = 0;
        end
        4'b1000:
        begin
            s1 = 1;
            wa = 0;
            we = 0;
            raa = 3;
            rea = 1;
            rab = 3;
            reb = 1;
            c = 0;          //c = 2
            s2 = 1;
            done = 1;
        end
        endcase
    end
        
endmodule
