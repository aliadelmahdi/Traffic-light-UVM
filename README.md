# Traffic Light Verification Using SystemVerilog and UVM

This repository contains the verification environment for a traffic light design, developed using SystemVerilog. The design itself was implemented in a separate repository ([32-Verilog-Mini-Projects](https://github.com/sudhamshu091/32-Verilog-Mini-Projects)), while this repository focuses solely on the verification aspect.

## Overview

- **Design Under Test (DUT):** Traffic light system implemented in Verilog.
- **Verification Environment:** UVM-based testbench written in SystemVerilog.
- **Assertions:** SystemVerilog assertions (SVA) were implemented to check design behavior.
- **Coverage:** Functional coverage and code coverage were used to track verification plan goals and ensure 100% coverage of code and functionality.

## Repository Structure

The system verilog/verilog files are organized as follows:

```
# interface/
# ├── traffic_defines.svh
# ├── traffic_if.sv
# └── shared_pkg.sv
#
# design/traffic_design/
# ├── traffic_light.v
# └── golden_model.sv
#
# design/traffic_Assertions/
# └── traffic_sva.sv
#
# objects/
# ├── traffic_config.sv
# ├── traffic_seq_item.sv
# ├── traffic_main_sequence.sv
# └── traffic_reset_sequence.sv
#
# top/test/enviroment/
# ├── traffic_env.sv
# ├── scoreboard/traffic_scoreboard.sv
# ├── coverage_collector/traffic_coverage_collector.sv
# └── agent/
#     ├── traffic_agent.sv
#     ├── sequencer/traffic_sequencer.sv
#     ├── driver/traffic_driver.sv
#     └── monitor/traffic_monitor.sv
#
# top/test/
# └── test.sv
#
# top/
# └── top.sv
```

## Features

- **UVM Testbench:** Comprehensive UVM-based testbench that drives the DUT and collects results.
- **SystemVerilog Assertions:** Assertions to check for protocol compliance and correct behavior of the traffic light design.
- **Coverage-Driven Verification:** 
  - Functional coverage ensures all intended functionalities of the traffic light design are exercised.
  - Code coverage ensures every line of code in the DUT is verified.

## How to Run the Verification

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/aliadelmahdi/Traffic-light-UVM.git
   ```
2. **Set Up the Simulation Environment:**  
   Make sure you have a SystemVerilog simulator installed (e.g., VCS, QuestaSim, or any other supporting UVM).
3. **Run the Testbench:**
   Execute your simulation script (e.g., `run.tcl`) as per your simulation environment instructions.

## Acknowledgements

- **Design Implementation:** The traffic light design was implemented in the [32-Verilog-Mini-Projects](https://github.com/sudhamshu091/32-Verilog-Mini-Projects) repository.
- **Verification Effort:** This repository focuses on the verification of the traffic light design using a robust UVM environment and advanced SystemVerilog assertions.
---
