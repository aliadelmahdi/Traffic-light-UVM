package traffic_monitor_pkg;

    import uvm_pkg::*,
           traffic_seq_item_pkg::*;
    `include "uvm_macros.svh"
           import shared_pkg::*;

    class traffic_monitor extends uvm_monitor;
        `uvm_component_utils (traffic_monitor)
        virtual traffic_if t_if;
        traffic_seq_item response_seq_item;
        uvm_analysis_port #(traffic_seq_item) monitor_ap;

        function new(string name = "traffic_monitor",uvm_component parent);
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
                response_seq_item = traffic_seq_item::type_id::create("response_seq_item");
                @(negedge t_if.clk);
                response_seq_item.sensor_A = sensor_state_e'(t_if.sensor_A);
                response_seq_item.sensor_B = sensor_state_e'(t_if.sensor_B);

                response_seq_item.red_A = light_state_e'(t_if.red_A);
                response_seq_item.red_A_ref = light_state_e'(t_if.red_A_ref);
                response_seq_item.red_B = light_state_e'(t_if.red_B);
                response_seq_item.red_B_ref = light_state_e'(t_if.red_B_ref);

                response_seq_item.green_A = light_state_e'(t_if.green_A);
                response_seq_item.green_A_ref = light_state_e'(t_if.green_A_ref);
                response_seq_item.green_B = light_state_e'(t_if.green_B);
                response_seq_item.green_B_ref = light_state_e'(t_if.green_B_ref);

                response_seq_item.yellow_A = light_state_e'(t_if.yellow_A);
                response_seq_item.yellow_A_ref = light_state_e'(t_if.yellow_A_ref);
                response_seq_item.yellow_B = light_state_e'(t_if.yellow_B);
                response_seq_item.yellow_B_ref = light_state_e'(t_if.yellow_B_ref);
                response_seq_item.rst =t_if.rst;
                response_seq_item.cs =state_e'(t_if.cs);

                 monitor_ap.write(response_seq_item);
                `uvm_info("run_phase", response_seq_item.sprint(), UVM_HIGH)
            end

        endtask
        
    endclass : traffic_monitor

endpackage : traffic_monitor_pkg