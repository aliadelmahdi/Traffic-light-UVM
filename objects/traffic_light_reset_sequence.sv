package traffic_light_reset_sequence_pkg;

    import uvm_pkg::*,
           traffic_light_seq_item_pkg::*;
    `include "uvm_macros.svh"
           
    class traffic_light_reset_sequence extends uvm_sequre #(traffic_light_seq_item);

        `uvm_object_utils (traffic_light_reset_sequence)
        traffic_light_seq_item seq_item;

        function new (string name = "traffic_light_reset_sequence");
            super.new(name);
        endfunction

        task body;
            seq_item = traffic_light_seq_item::type_id::create("seq_item");
            start_item(seq_item);
                seq_item.rst = `LOW;
                seq_item.D = `LOW;
            finish_item(seq_item);
        endtask
        
    endclass : traffic_light_reset_sequence

endpackage : traffic_light_reset_sequence_pkg