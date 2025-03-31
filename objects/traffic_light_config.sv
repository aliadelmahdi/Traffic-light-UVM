package traffic_light_config_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class traffic_light_config extends uvm_object;

        `uvm_object_utils (traffic_light_config)
        virtual traffic_if t_if;

        // Default Constructor
        function new(string name = "traffic_light_config");
            super.new(name);
        endfunction
        
    endclass : traffic_light_config

endpackage : traffic_light_config_pkg