package traffic_coverage_pkg;
    import  uvm_pkg::*,
            traffic_driver_pkg::*,
            traffic_scoreboard_pkg::*,
            traffic_main_sequence_pkg::*,
            traffic_reset_sequence_pkg::*,
            traffic_seq_item_pkg::*,
            traffic_sequencer_pkg::*,
            traffic_monitor_pkg::*,
            traffic_config_pkg::*,
            shared_pkg::*,
            traffic_agent_pkg::*;

    `include "uvm_macros.svh"

    class traffic_coverage extends uvm_component;
        `uvm_component_utils(traffic_coverage)

        // Analysis Export for receiving transactions from monitors
        uvm_analysis_export #(traffic_seq_item) traffic_cov_export;
        uvm_tlm_analysis_fifo #(traffic_seq_item) traffic_cov_t;
        traffic_seq_item traffic_seq_item_cov;

        // Covergroup definitions
        covergroup traffic_cov_grp;
            rst_cp: coverpoint traffic_seq_item_cov.rst{
                bins active = {`HIGH};
                bins inactive = {`LOW};
                bins active_to_inactive = (`HIGH=>`LOW);
                bins inactive_to_active = (`LOW=>`HIGH);
            }

            sensor_A_cp: coverpoint traffic_seq_item_cov.sensor_A{
                bins CARS = {CARS};
                bins NO_CARS = {NO_CARS};
            }

            sensor_B_cp: coverpoint traffic_seq_item_cov.sensor_B{
                bins CARS = {CARS};
                bins NO_CARS = {NO_CARS};
            }

        endgroup
 
        // Constructor
        function new (string name = "traffic_coverage", uvm_component parent);
            super.new(name, parent);
            traffic_cov_grp = new();
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            traffic_cov_export = new("traffic_cov_export", this);
            traffic_cov_t = new("traffic_cov_t", this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            traffic_cov_export.connect(traffic_cov_t.analysis_export);
        endfunction

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                // Get the next transaction from the analysis FIFO.
                traffic_cov_t.get(traffic_seq_item_cov);
                traffic_cov_grp.sample();
            end
        endtask

    endclass : traffic_coverage

endpackage : traffic_coverage_pkg