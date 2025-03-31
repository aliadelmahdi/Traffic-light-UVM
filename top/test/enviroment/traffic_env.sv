package traffic_env_pkg; 
    import  uvm_pkg::*,
            traffic_driver_pkg::*,
            traffic_scoreboard_pkg::*,
            traffic_main_sequence_pkg::*,
            traffic_reset_sequence_pkg::*,
            traffic_seq_item_pkg::*,
            traffic_sequencer_pkg::*,
            traffic_monitor_pkg::*,
            traffic_config_pkg::*,
            traffic_agent_pkg::*,
            traffic_coverage_pkg::*;
    `include "uvm_macros.svh"
    class traffic_env extends uvm_env;
        `uvm_component_utils(traffic_env)

        traffic_agent t_agent;
        traffic_scoreboard t_sb;
        traffic_coverage t_cov;
        
        // Default Constructor
        function new (string name = "traffic_env", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase );
        super.build_phase (phase);
            t_agent = traffic_agent::type_id::create("t_agent",this);
            t_sb= traffic_scoreboard::type_id::create("t_sb",this);
            t_cov= traffic_coverage::type_id::create("t_cov",this);
        endfunction

        // Connect Phase
        function void connect_phase (uvm_phase phase );
            t_agent.t_agent_ap.connect(t_sb.traffic_sb_export);
            t_agent.t_agent_ap.connect(t_cov.traffic_cov_export);
        endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
        endtask
    endclass : traffic_env
endpackage : traffic_env_pkg