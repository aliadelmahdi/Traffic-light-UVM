package traffic_light_env_pkg; 
    import  uvm_pkg::*,
            traffic_light_driver_pkg::*,
            traffic_light_scoreboard_pkg::*,
            traffic_light_main_sequence_pkg::*,
            traffic_light_reset_sequence_pkg::*,
            traffic_light_seq_item_pkg::*,
            traffic_light_sequencer_pkg::*,
            traffic_light_monitor_pkg::*,
            traffic_light_config_pkg::*,
            traffic_light_agent_pkg::*,
            traffic_light_coverage_pkg::*;
    `include "uvm_macros.svh"
    class traffic_light_env extends uvm_env;
        `uvm_component_utils(traffic_light_env)

        traffic_light_agent t_agent;
        traffic_light_scoreboard t_sb;
        traffic_light_coverage t_cov;
        
        // Default Constructor
        function new (string name = "traffic_light_env", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase );
        super.build_phase (phase);
            t_agent = traffic_light_agent::type_id::create("t_agent",this);
            t_sb= traffic_light_scoreboard::type_id::create("t_sb",this);
            t_cov= traffic_light_coverage::type_id::create("t_cov",this);
        endfunction

        // Connect Phase
        function void connect_phase (uvm_phase phase );
            t_agent.t_agent_ap.connect(t_sb.traffic_light_sb_export);
            t_agent.t_agent_ap.connect(t_cov.traffic_light_cov_export);
        endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
        endtask
    endclass : traffic_light_env
endpackage : traffic_light_env_pkg