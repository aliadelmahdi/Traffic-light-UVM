package traffic_seq_item_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "traffic_defines.svh" // For macros
    import shared_pkg::*;

    class traffic_seq_item extends uvm_sequence_item;
       // RTL Design Signals
        //inputs
        rand sensor_state_e sensor_A;
        rand sensor_state_e sensor_B;
        rand bit rst;
        //outputs
        light_state_e red_A, red_B;
        light_state_e green_A, green_B;
        light_state_e yellow_A, yellow_B;
        // Golden Model Signals
        light_state_e red_A_ref, red_B_ref;
        light_state_e green_A_ref, green_B_ref;
        light_state_e yellow_A_ref, yellow_B_ref;

        state_e cs;


        // Default Constructor
        function new(string name = "traffic_seq_item");
            super.new(name);
        endfunction

        `uvm_object_utils_begin(traffic_seq_item)
        `uvm_field_int(rst, UVM_DEFAULT)
        `uvm_field_enum(sensor_state_e,sensor_A, UVM_DEFAULT)
        `uvm_field_enum(sensor_state_e,sensor_B, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,red_A, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,red_A_ref, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,red_B, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,red_B_ref, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,yellow_A, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,yellow_A_ref, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,yellow_B, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,yellow_B_ref, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,green_A, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,green_A_ref, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,green_B, UVM_DEFAULT)
        `uvm_field_enum(light_state_e,green_B_ref, UVM_DEFAULT)
        `uvm_object_utils_end


        constraint c_reset_distribution {
            rst dist { `LOW := 97, `HIGH := 3 };
        }
        constraint c_sensor_A_distribution {
            sensor_A dist { NO_CARS := 40, CARS := 60 };
        }
        constraint c_sensor_B_distribution {
            sensor_B dist { NO_CARS := 30, CARS := 70 };
        }

    endclass : traffic_seq_item

endpackage : traffic_seq_item_pkg