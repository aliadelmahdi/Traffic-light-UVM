package traffic_reset_sequence_pkg;

    import uvm_pkg::*,
           traffic_seq_item_pkg::*;
    `include "uvm_macros.svh"
    import shared_pkg::*;
    `include "traffic_defines.svh" // For macros
           
    class traffic_reset_sequence extends uvm_sequence #(traffic_seq_item);

        `uvm_object_utils (traffic_reset_sequence)
        traffic_seq_item seq_item;

        function new (string name = "traffic_reset_sequence");
            super.new(name);
        endfunction

        task body;
            seq_item = traffic_seq_item::type_id::create("seq_item");
            start_item(seq_item);
                seq_item.sensor_A = NO_CARS;
                seq_item.sensor_B = NO_CARS;
                seq_item.rst = `LOW;
            finish_item(seq_item);
        endtask
        
    endclass : traffic_reset_sequence

endpackage : traffic_reset_sequence_pkg