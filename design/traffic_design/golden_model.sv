import shared_pkg::*;
`include "traffic_defines.svh" // For macros
`timescale `TIME_UNIT / `TIME_PRECISION

module golden_model (
    input logic clk,rst,
    input sensor_state_e sensor_A,
    input sensor_state_e sensor_B,
    output logic  red_A,
    output logic  red_B,
    output logic  green_A,
    output logic  green_B, 
    output logic  yellow_A,
    output logic  yellow_B
);

    state_e cs;
    state_e ns;
    
    always @(cs or sensor_A or sensor_B) begin
        {red_A, red_B, green_A, green_B, yellow_A, yellow_B} = {OFF, OFF, OFF, OFF, OFF, OFF};
        ns = CYCLE_0;
        case (cs)
            CYCLE_0, CYCLE_1, CYCLE_2, CYCLE_3, CYCLE_4: begin
                green_A = ON;
                red_B = ON;
                ns = state_e'(cs + 1);
            end
            CYCLE_5: begin
                green_A = ON;
                red_B = ON;
                if (sensor_B == CARS)
                    ns = CYCLE_6;
                else
                    ns = CYCLE_5;
            end
            CYCLE_6: begin
                yellow_A = ON;
                red_B = ON;
                ns = CYCLE_7;
            end
            CYCLE_7, CYCLE_8, CYCLE_9, CYCLE_10: begin
                red_A = ON;
                green_B = ON;
                ns = state_e'(cs + 1);
            end
            CYCLE_11: begin
                red_A = ON;
                green_B = ON;
                if (sensor_A == CARS | sensor_B == NO_CARS)
                    ns = CYCLE_12;
                else
                    ns = CYCLE_11;
            end
            CYCLE_12: begin
                red_A = ON;
                yellow_B = ON;
                ns = CYCLE_0;
            end
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
        cs <= CYCLE_0;
        else
        cs <= ns;
    end

endmodule