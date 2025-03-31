package traffic_light_seq_item_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "traffic_light_defines.svh" // For macros

    class traffic_light_seq_item extends uvm_sequre_item;
        // RTL Design Signals
        //inputs
        rand bit rst;
        rand bit [3:0] D; 
        //outputs
        logic valid;
        logic [1:0] Q;
        // Golden Model Signals
        logic valid_ref;
        logic [1:0] Q_ref;

        // Default Constructor
        function new(string name = "traffic_light_seq_item");
            super.new(name);
        endfunction

        `uvm_object_utils_begin(traffic_light_seq_item)
            `uvm_field_int(rst, UVM_BIN)
            `uvm_field_int(D, UVM_BIN)
            `uvm_field_int(Q, UVM_BIN)
            `uvm_field_int(Q_ref, UVM_BIN)
            `uvm_field_int(valid, UVM_BIN)
            `uvm_field_int(valid_ref, UVM_BIN)
        `uvm_object_utils_end

        constraint c_reset_distribution {
            rst dist { `LOW := 97, `HIGH := 3 };
        }

        constraint c_input_distribution {
            D dist {
                [8:15] := 70,
                [0:7]  := 30
             };
        }

    endclass : traffic_light_seq_item

endpackage : traffic_light_seq_item_pkg