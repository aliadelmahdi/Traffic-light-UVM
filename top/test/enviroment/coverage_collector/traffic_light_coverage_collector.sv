package traffic_light_coverage_pkg;
    import  uvm_pkg::*,
            traffic_light_driver_pkg::*,
            traffic_light_scoreboard_pkg::*,
            traffic_light_main_sequence_pkg::*,
            traffic_light_reset_sequence_pkg::*,
            traffic_light_seq_item_pkg::*,
            traffic_light_sequencer_pkg::*,
            traffic_light_monitor_pkg::*,
            traffic_light_config_pkg::*,
            traffic_light_agent_pkg::*;
    `include "uvm_macros.svh"

            class traffic_light_coverage extends uvm_component;
        `uvm_component_utils(traffic_light_coverage)

        // Analysis Export for receiving transactions from monitors
        uvm_analysis_export #(traffic_light_seq_item) traffic_light_cov_export;
        uvm_tlm_analysis_fifo #(traffic_light_seq_item) traffic_light_cov;
        traffic_light_seq_item traffic_light_seq_item_cov;

        // Covergroup definitions
        covergroup traffic_light_cov_grp;
            rst_cp: coverpoint traffic_light_seq_item_cov.rst{
                bins active = {`HIGH};
                bins inactive = {`LOW};
                bins active_to_inactive = (`HIGH=>`LOW);
                bins inactive_to_active = (`LOW=>`HIGH);
            }
        endgroup
 
        // Constructor
        function new (string name = "traffic_light_coverage", uvm_component parent);
            super.new(name, parent);
            traffic_light_cov_grp = new();
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            traffic_light_cov_export = new("traffic_light_cov_export", this);
            traffic_light_cov = new("traffic_light_cov", this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            traffic_light_cov_export.connect(traffic_light_cov.analysis_export);
        endfunction

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                // Get the next transaction from the analysis FIFO.
                traffic_light_cov.get(traffic_light_seq_item_cov);
                traffic_light_cov_grp.sample();
            end
        endtask

    endclass : traffic_light_coverage

endpackage : traffic_light_coverage_pkg