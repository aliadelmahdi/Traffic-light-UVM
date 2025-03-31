package shared_pkg;
    
   typedef enum logic [1:0]  {RED,YELLOW,GREEN} colors;
   typedef enum logic [3:0] {
        CYCLE_0,
        CYCLE_1,
        CYCLE_2,
        CYCLE_3,
        CYCLE_4,
        CYCLE_5,
        CYCLE_6,
        CYCLE_7,
        CYCLE_8,
        CYCLE_9,
        CYCLE_10,
        CYCLE_11,
        CYCLE_12
    } state_e;

    typedef enum logic {
        NO_CARS = 0,
        CARS = 1
    } sensor_state_e;

    typedef  enum logic {
        OFF = 0,
        ON = 1
    } light_state_e;

endpackage