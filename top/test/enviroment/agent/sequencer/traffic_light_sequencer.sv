package traffic_light_sequencer_pkg;

    import uvm_pkg::*,
           traffic_light_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class traffic_light_sequencer extends uvm_sequencer #(traffic_light_seq_item);

        `uvm_component_utils(traffic_light_sequencer);

        function new(string name = "traffic_light_sequre", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
        endtask
    endclass : traffic_light_sequencer

endpackage : traffic_light_sequencer_pkg