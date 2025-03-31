import uvm_pkg::*;
import traffic_light_env_pkg::*;
import traffic_light_test_pkg::*;
`include "traffic_light_defines.svh" // For macros
`timescale `TIME_UNIT / `TIME_PRECISION

module tb_top;
    bit clk;
    // Clock Generation
    initial begin
        clk = `LOW;
        forever #(`CLK_PERIOD/2) clk = ~ clk;
    end

    
    traffic_light_env env_instance;
    traffic_light_test test;

    traffic_if t_if (clk);
    traffic_light DUT (
        );

    golden_model GLD (
         );



    bind traffic_light traffic_light_sva traffic_light_sva_inst (
        );    

    initial begin
        uvm_top.set_report_verbosity_level(UVM_MEDIUM); // Set verbosity level
        uvm_top.finish_on_completion = `DISABLE_FINISH; // Prevent UVM from calling $finish
        uvm_config_db#(virtual traffic_if)::set(null, "*", "t_if", t_if); // Set traffic_light interface globally
        run_test("traffic_light_test"); // Start the UVM test
        $stop; // Stop simulation after test execution
    end
endmodule : tb_top