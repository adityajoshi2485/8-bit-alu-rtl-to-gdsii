# SDC constraints reconstructed from the documented
# RTL-to-GDSII workshop project requirements.

# 100 MHz clock = 10 ns period
create_clock -name clk -period 10.0 [get_ports clk]

# Clock uncertainty
set_clock_uncertainty 0.2 [get_clocks clk]

# Input/output timing assumptions
set_input_delay 1.0 -clock clk [get_ports {A B opcode}]
set_output_delay 1.0 -clock clk [get_ports {result zero carry}]

# Input transition
set_input_transition 0.1 [get_ports {A B opcode}]

# Output load
set_load 0.05 [get_ports {result zero carry}]