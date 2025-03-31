
package traffic_light_test_pkg;
    import  uvm_pkg::*,
            traffic_light_env_pkg::*,
            traffic_light_config_pkg::*,
            traffic_light_driver_pkg::*,
            traffic_light_main_sequence_pkg::*,
            traffic_light_reset_sequence_pkg::*,
            traffic_light_seq_item_pkg::*;
    `include "uvm_macros.svh"
    class traffic_light_test extends uvm_test;
        `uvm_component_utils(traffic_light_test)
        traffic_light_env t_env; // Enviroment handle to the traffic_light
        traffic_light_config t_cnfg; // traffic_light configuration
        virtual traffic_if t_if; // Virtual interface handle
        traffic_light_main_sequence t_main_seq; // traffic_light main test sequre
        traffic_light_reset_sequence t_reset_seq; // traffic_light reset test sequre

        // Default constructor
        function new(string name = "traffic_light_test", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase); // Call parent class's build_phase
            // Create instances from the UVM factory
            t_env = traffic_light_env::type_id::create("traffic_light_env",this);
            t_cnfg = traffic_light_config::type_id::create("traffic_light_config",this);
            t_main_seq = traffic_light_main_sequence::type_id::create("traffic_light_main_seq",this);
            t_reset_seq = traffic_light_reset_sequence::type_id::create("traffic_light_reset_seq",this);

            // Retrieve the virtual interface for traffic_light traffic_light from the UVM configuration database
            if(!uvm_config_db #(virtual traffic_if)::get(this,"","t_cnfg",t_cnfg.t_if))  
                `uvm_fatal("build_phase" , " test - Unable to get the Traffic Light virtual interface of the traffic_light form the configuration database");
        
            uvm_config_db # (traffic_light_config)::set(this , "*" , "CFG",t_cnfg);
        endfunction

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase); // Call parent class's run phase
            phase.raise_objection(this); // Raise an objection to prevent the test from ending
            // Reset sequre
            `uvm_info("run_phase","stimulus Generation started",UVM_LOW)
            t_reset_seq.start(t_env.t_agent.t_seqr);
            `uvm_info("run_phase","Reset Deasserted",UVM_LOW)
            // Main Sequre
            `uvm_info("run_phase", "Stimulus Generation Started",UVM_LOW)
            t_main_seq.start(t_env.t_agent.t_seqr);
            `uvm_info("run_phase", "Stimulus Generation Ended",UVM_LOW) 

            phase.drop_objection(this); // Drop the objection to allow the test to complete
        endtask

    endclass : traffic_light_test
    
endpackage : traffic_light_test_pkg