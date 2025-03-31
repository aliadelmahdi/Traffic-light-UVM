package traffic_light_scoreboard_pkg;
    import  uvm_pkg::*,
            traffic_light_seq_item_pkg::*;
    
    `include "traffic_light_defines.svh" // For macros

    `include "uvm_macros.svh"
    class traffic_light_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(traffic_light_scoreboard)
        
        uvm_analysis_export #(traffic_light_seq_item) traffic_light_sb_export;
        uvm_tlm_analysis_fifo #(traffic_light_seq_item) t_sb;
        traffic_light_seq_item traffic_light_seq_item_sb;


        int error_count = 0, correct_count = 0;
        
        // Default Constructor
        function new(string name = "traffic_light_scoreboard",uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            traffic_light_sb_export = new("traffic_light_sb_export",this);
            t_sb=new("t_sb",this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            traffic_light_sb_export.connect(t_sb.analysis_export);
        endfunction

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                t_sb.get(traffic_light_seq_item_sb);
                check_results(traffic_light_seq_item_sb);
            end
        endtask

        // Report Phase
        function void report_phase(uvm_phase phase);
            super.report_phase(phase);
            `uvm_info("report_phase",$sformatf("At time %0t: Simulation Ends and Error count= %0d, Correct count= %0d",$time,error_count,correct_count),UVM_MEDIUM);
        endfunction

        // function void check_results(traffic_light_seq_item seq_item_ch);
        //     if ( seq_item_ch.Q != seq_item_ch.Q_ref
        //         || seq_item_ch.valid != seq_item_ch.valid_ref
        //         ) begin
        //         error_count++;
        //         `uvm_error("run_phase","Comparison Error between the golden model and the DUT")
        //         `uvm_info("run_phase", $sformatf("RAM Transaction:\n%s", seq_item_ch.sprint()), UVM_MEDIUM)
        //     end
        //     else
        //         correct_count++;
        // endfunction
    endclass : traffic_light_scoreboard

endpackage : traffic_light_scoreboard_pkg