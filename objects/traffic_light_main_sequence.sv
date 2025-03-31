package traffic_light_main_sequence_pkg;

    import uvm_pkg::*,
           traffic_light_seq_item_pkg::*;
    `include "uvm_macros.svh"
    `include "traffic_light_defines.svh" // For macros

    class traffic_light_main_sequence extends uvm_sequre #(traffic_light_seq_item);

        `uvm_object_utils (traffic_light_main_sequence);
        traffic_light_seq_item seq_item;

        function new(string name = "traffic_light_main_sequence");
            super.new(name);            
        endfunction
        
        task body;

            repeat(`TEST_ITER_SMALL) begin
                seq_item = traffic_light_seq_item::type_id::create("seq_item");
                start_item(seq_item);
                assert(seq_item.randomize()) else $error("Master Randomization Failed");
                finish_item(seq_item);
            end

        endtask
        
    endclass : traffic_light_main_sequence

endpackage : traffic_light_main_sequence_pkg