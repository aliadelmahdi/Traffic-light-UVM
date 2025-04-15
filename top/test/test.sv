
package traffic_test_pkg;
    import  uvm_pkg::*,
            traffic_env_pkg::*,
            traffic_config_pkg::*,
            traffic_driver_pkg::*,
            traffic_main_sequence_pkg::*,
            traffic_reset_sequence_pkg::*,
            traffic_seq_item_pkg::*;
    `include "uvm_macros.svh"
    class traffic_test extends uvm_test;
        `uvm_component_utils(traffic_test)
        traffic_env t_env; // Enviroment handle to the traffic
        traffic_config t_cnfg; // traffic configuration
        virtual traffic_if t_if; // Virtual interface handle
        traffic_main_sequence t_main_seq; // traffic main test sequence
        traffic_reset_sequence t_reset_seq; // traffic reset test sequence

        // Default constructor
        function new(string name = "traffic_test", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase); // Call parent class's build_phase
            // Create instances from the UVM factory
            t_env = traffic_env::type_id::create("env",this);
            t_cnfg = traffic_config::type_id::create("traffic_config",this);
            t_main_seq = traffic_main_sequence::type_id::create("traffic_main_seq",this);
            t_reset_seq = traffic_reset_sequence::type_id::create("reset_seq",this);

            // Retrieve the virtual interface for traffic traffic from the UVM configuration database
            if(!uvm_config_db #(virtual traffic_if)::get(this,"","t_if",t_cnfg.t_if))  
                `uvm_fatal("build_phase" , " test - Unable to get the traffic virtual interface of the traffic from the configuration database");
        
            uvm_config_db # (traffic_config)::set(this , "*" , "CFG",t_cnfg);
        endfunction

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase); // Call parent class's run phase
            phase.raise_objection(this); // Raise an objection to prevent the test from ending
            // Reset sequence
            `uvm_info("run_phase","stimulus Generation started",UVM_LOW)
            t_reset_seq.start(t_env.t_agent.t_seqr);
            `uvm_info("run_phase","Reset Deasserted",UVM_LOW)
            // Main Sequence
            `uvm_info("run_phase", "Stimulus Generation Started",UVM_LOW)
            t_main_seq.start(t_env.t_agent.t_seqr);
            `uvm_info("run_phase", "Stimulus Generation Ended",UVM_LOW) 

            phase.drop_objection(this); // Drop the objection to allow the test to complete
        endtask

    endclass : traffic_test
    
endpackage : traffic_test_pkg
