package traffic_agent_pkg;
    import  uvm_pkg::*,
            traffic_seq_item_pkg::*,
            traffic_driver_pkg::*,
            traffic_main_sequence_pkg::*,
            traffic_reset_sequence_pkg::*,
            traffic_sequencer_pkg::*,
            traffic_monitor_pkg::*,
            traffic_config_pkg::*;
    `include "uvm_macros.svh"
 
    class traffic_agent extends uvm_agent;

        `uvm_component_utils(traffic_agent)
        traffic_sequencer t_seqr;
        traffic_driver t_drv;
        traffic_monitor t_mon;
        traffic_config t_cnfg;
        uvm_analysis_port #(traffic_seq_item) t_agent_ap;

        // Default Constructor
        function new(string name = "traffic_agent", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            if(!uvm_config_db #(traffic_config)::get(this,"","CFG",t_cnfg)) 
                `uvm_fatal ("build_phase","Unable to get the traffic configuration object from the database")
            
            t_drv = traffic_driver::type_id::create("t_drv",this);
            t_seqr = traffic_sequencer::type_id::create("t_seqr",this);
            t_mon = traffic_monitor::type_id::create("t_mon",this);
            t_agent_ap = new("t_agent_ap",this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            t_drv.t_if = t_cnfg.t_if;
            t_mon.t_if = t_cnfg.t_if;
            t_drv.seq_item_port.connect(t_seqr.seq_item_export);
            t_mon.monitor_ap.connect(t_agent_ap);
        endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
        endtask
    endclass : traffic_agent

endpackage : traffic_agent_pkg