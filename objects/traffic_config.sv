package traffic_config_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class traffic_config extends uvm_object;

        `uvm_object_utils (traffic_config)
        virtual traffic_if t_if;

        // Default Constructor
        function new(string name = "traffic_config");
            super.new(name);
        endfunction
        
    endclass : traffic_config

endpackage : traffic_config_pkg