import shared_pkg::*;

interface traffic_if(input bit clk);
    logic rst;
    state_e cs;

    logic sensor_A, sensor_B;
    logic red_A, red_B;
    logic green_A, green_B;
    logic yellow_A, yellow_B;

    logic red_A_ref, red_B_ref;
    logic green_A_ref, green_B_ref;
    logic yellow_A_ref, yellow_B_ref;

endinterface
