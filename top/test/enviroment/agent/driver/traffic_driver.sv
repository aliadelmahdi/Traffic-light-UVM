package traffic_driver_pkg;

    import  uvm_pkg::*,
            traffic_config_pkg::*,
            traffic_main_sequence_pkg::*,
            traffic_reset_sequence_pkg::*,
            traffic_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class traffic_driver extends uvm_driver #(traffic_seq_item);
        `uvm_component_utils(traffic_driver)
        virtual traffic_if t_if;
        traffic_seq_item stimulus_seq_item;

        // Default Constructor
        function new(string name = "traffic_driver", uvm_component parent);
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
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                stimulus_seq_item = traffic_seq_item::type_id::create("traffic_stimulus_seq_item");
                seq_item_port.get_next_item(stimulus_seq_item);
                t_if.sensor_A = stimulus_seq_item.sensor_A;
                t_if.sensor_B = stimulus_seq_item.sensor_B;
                t_if.rst = stimulus_seq_item.rst;
                @(negedge t_if.clk)
                seq_item_port.item_done();
                `uvm_info("run_phase",stimulus_seq_item.sprint(),UVM_HIGH)
            end
        endtask
        
    endclass : traffic_driver

endpackage : traffic_driver_pkg