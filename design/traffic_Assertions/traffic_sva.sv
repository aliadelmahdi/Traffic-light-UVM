/*  
    This assertion file follows the **Verification Plan** numbering  
    Each section corresponds to a specific verification requirement

    The numbers (e.g., 1, 2.2) match the corresponding test items  
    from the **Verification Plan** for traceability and clarity
*/
`include "traffic_defines.svh" // For macros
`timescale `TIME_UNIT / `TIME_PRECISION
import shared_pkg::*;

  module traffic_sva(
    input logic clk,rst,
    input logic sensor_A,
    input logic sensor_B,

    input logic red_A,
    input logic red_B,
    input logic green_A,
    input logic green_B, 
    input logic yellow_A,
    input logic yellow_B,
    input logic [3:0]  cs

  );
  // ** 1: Reset Verification **\\

  // 1.1: Reset Behavior
  property reset_check;
    (rst) |=> (!red_A
              && red_B      
              && green_A      
              && !green_B      
              && !yellow_A      
              && !yellow_B);     
  endproperty

  reset_assert: assert property (@(posedge clk or posedge rst) reset_check)
    else $error("Failed to deassert the outputs when reset is asserted");

  // ** 2: Core Features **\\
  
  // 2.2: Road B Green Light Activation
  property road_B_green_check;
    @(posedge clk) disable iff (rst)
      (cs==CYCLE_5 && sensor_B == CARS) |=> (yellow_A) ##1 (red_A && green_B);
  endproperty

  road_B_green_assert: assert property (road_B_green_check)
    else $error("Road B did not take its chance in the green time even when the road has cars");

  // 2.3: Road A Priority Enforcement
  property road_A_priority_check;
    @(posedge clk) disable iff(rst)
      (cs==CYCLE_11 && sensor_A == CARS ) |=> (yellow_B) ##1 (red_B && green_A);
  endproperty

  road_A_priority_assert: assert property (road_A_priority_check)
    else $error("The system did not priorities road A when the road has cars");

  // 2.4: Smart System feature 1
  property smart_system_feature_1_check;
    @(posedge clk) disable iff(rst)
      (cs == CYCLE_11 && sensor_B == NO_CARS) |=> (yellow_B) ##1 (red_B && green_A);
  endproperty

  smart_system_feature_1_assert: assert property (smart_system_feature_1_check)
    else $error("The system failed to apply the first feature: move to road A if road B has no cars");

  // 2.5: Smart System feature 2
  property smart_system_feature_2_check;
    @(posedge clk) disable iff(rst)
      (cs == CYCLE_5 && sensor_B == NO_CARS) |=> (cs == CYCLE_5);
  endproperty

  smart_system_feature_2_assert: assert property (smart_system_feature_2_check)
    else $error("The system failed to apply the second feature: stay at road A when road B has no cars");

  // 2.6: Smart System feature 3
  property smart_system_feature_3_check;
    @(posedge clk) disable iff(rst)
      (cs == CYCLE_11 && sensor_A == NO_CARS && sensor_B == CARS) |=>  (cs == CYCLE_11);
  endproperty

  smart_system_feature_3_assert: assert property (smart_system_feature_3_check)
    else $error("The system failed to apply the third feature: stay at road B when it has cars if road A has no cars");

    // 2.7: Light algorithm
    property light_algorithm_A_check;
      @(posedge clk) disable iff(rst)
      (green_A) |=> (yellow_A) |=> (red_A);
    endproperty

    property light_algorithm_B_check;
      @(posedge clk) disable iff(rst)
      (green_B) |=> (yellow_B) |=> (red_B);
    endproperty

    light_algorithm_A_cover: cover property (light_algorithm_A_check);
    light_algorithm_B_cover: cover property (light_algorithm_B_check);


endmodule


