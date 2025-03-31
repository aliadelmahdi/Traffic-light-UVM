module traffic_light (
    input clk,rst,
    input Sa,
    input Sb,
    output Ra,
    output Rb,
    output Ga,
    output Gb, 
    output Ya,
    output Yb
);

    reg Ra_tmp;
    reg Rb_tmp;
    reg Ga_tmp;
    reg Gb_tmp;
    reg Ya_tmp;
    reg Yb_tmp;

    reg [3:0] state;
    reg [3:0] nextstate;

    parameter [1:0] R = 0;
    parameter [1:0] Y = 1;
    parameter [1:0] G = 2;


    assign Ra = Ra_tmp;
    assign Rb = Rb_tmp;
    assign Ga = Ga_tmp;
    assign Gb = Gb_tmp;
    assign Ya = Ya_tmp;
    assign Yb = Yb_tmp;

    always @(*) begin
        Ra_tmp = 1'b0;
        Rb_tmp = 1'b0;
        Ga_tmp = 1'b0;
        Gb_tmp = 1'b0;
        Ya_tmp = 1'b0;
        Yb_tmp = 1'b0;
        nextstate = 0;

        case (state)
            0, 1, 2, 3, 4: begin
                Ga_tmp = 1'b1;
                Rb_tmp = 1'b1;
                nextstate = state + 1;
            end

            5: begin
                Ga_tmp = 1'b1;
                Rb_tmp = 1'b1;
                if (Sb == 1'b1)
                    nextstate = 6;
                else
                    nextstate = 5;
            end

            6: begin
                Ya_tmp = 1'b1;
                Rb_tmp = 1'b1;
                nextstate = 7;
            end

            7, 8, 9, 10: begin
                Ra_tmp = 1'b1;
                Gb_tmp = 1'b1;
                nextstate = state + 1;
            end

            11: begin
                Ra_tmp = 1'b1;
                Gb_tmp = 1'b1;
                if (Sa == 1'b1 | Sb == 1'b0)
                    nextstate = 12;
                else
                    nextstate = 11;
            end

            12: begin
                Ra_tmp = 1'b1;
                Yb_tmp = 1'b1;
                nextstate = 0;
            end
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if(rst)
        state <= 0;
        else
        state <= nextstate;
    end

endmodule
