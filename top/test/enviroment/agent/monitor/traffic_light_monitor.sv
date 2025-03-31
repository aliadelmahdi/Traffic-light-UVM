package traffic_light_monitor_pkg;

    import uvm_pkg::*,
           traffic_light_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class traffic_light_monitor extends uvm_monitor;
        `uvm_component_utils (traffic_light_monitor)
        virtual traffic_if t_if;
        traffic_light_seq_item response_seq_item;
        uvm_analysis_port #(traffic_light_seq_item) monitor_ap;

        function new(string name = "traffic_light_monitor",uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            monitor_ap = new ("monitor_ap",this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                response_seq_item = traffic_light_seq_item::type_id::create("response_seq_item");
                @(negedge t_if.clk);
                response_seq_item.rst = t_if.rst;
                 monitor_ap.write(response_seq_item);
                `uvm_info("run_phase", response_seq_item.sprint(), UVM_HIGH)
            end

        endtask
        
    endclass : traffic_light_monitor

endpackage : traffic_light_monitor_pkg