import uvm_pkg::*;
import traffic_env_pkg::*;
import traffic_test_pkg::*;
import shared_pkg::*;

`include "traffic_defines.svh" // For macros
`timescale `TIME_UNIT / `TIME_PRECISION

module tb_top;
    bit clk;
    // Clock Generation
    initial begin
        clk = `LOW;
        forever #(`CLK_PERIOD/2) clk = ~ clk;
    end

    
    traffic_env env_instance;
    traffic_test test;

    traffic_if t_if (clk);
    // Instantiate Device Under Test (DUT)
    traffic_light DUT (
        .clk(t_if.clk),
        .Sa(t_if.sensor_A),
        .Sb(t_if.sensor_B),
        .Ra(t_if.red_A),
        .Rb(t_if.red_B),
        .Ga(t_if.green_A),
        .Gb(t_if.green_B),
        .Ya(t_if.yellow_A),
        .Yb(t_if.yellow_B),
        .rst(t_if.rst)
    );

    assign t_if.cs  = state_e'(DUT.state);  
    // Instantiate Golden Model
    golden_model GLD (
        .clk(t_if.clk),
        .sensor_A(sensor_state_e'(t_if.sensor_A)),
        .sensor_B(sensor_state_e'(t_if.sensor_B)),
        .red_A(t_if.red_A_ref),
        .red_B(t_if.red_B_ref),
        .green_A(t_if.green_A_ref),
        .green_B(t_if.green_B_ref),
        .yellow_A(t_if.yellow_A_ref),
        .yellow_B(t_if.yellow_B_ref),
        .rst(t_if.rst)
    );

    // Bind SVA to DUT with signals
    bind traffic_light traffic_sva traffic_sva_inst (
        .clk(clk),
        .sensor_A(Sa),
        .sensor_B(Sb),
        .red_A(Ra),
        .red_B(Rb),
        .green_A(Ga),
        .green_B(Gb),
        .yellow_A(Ya),
        .yellow_B(Yb),
        .rst(rst),
        .cs(state)
    );

    initial begin
        uvm_top.set_report_verbosity_level(UVM_MEDIUM); // Set verbosity level
        uvm_top.finish_on_completion = `DISABLE_FINISH; // Prevent UVM from calling $finish
        uvm_config_db#(virtual traffic_if)::set(null, "*", "t_if", t_if); // Set traffic interface globally
        run_test("traffic_test"); // Start the UVM test
        $stop; // Stop simulation after test execution
    end
endmodule : tb_top