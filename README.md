\# 8-bit ALU — RTL-to-GDSII Implementation



\## Overview



An 8-bit Arithmetic and Logic Unit (ALU) implemented and taken through a complete RTL-to-GDSII ASIC design flow using Synopsys EDA tools and the SAED 32nm technology library.



The project covers RTL design, functional verification, logic synthesis, timing constraint definition, floorplanning, power planning, placement, clock tree synthesis (CTS), routing, static timing analysis (STA), and GDSII generation.



\## Design Specifications



| Parameter | Specification |

|---|---|

| Design | 8-bit Arithmetic and Logic Unit |

| HDL | Verilog HDL |

| Technology | SAED 32nm |

| Clock Period | 10 ns |

| Target Frequency | 100 MHz |

| Architecture | Synchronous pipelined |

| Reset | Asynchronous active-high |

| Top Module | `alu\_top` |



\## ALU Architecture



The ALU uses a three-stage architecture:



```text

&#x20;       Inputs

&#x20;     A, B, Opcode

&#x20;          |

&#x20;          v

&#x20;  +----------------+

&#x20;  | Input Registers|

&#x20;  +----------------+

&#x20;          |

&#x20;          v

&#x20;  +----------------+

&#x20;  |   ALU Core     |

&#x20;  |                |

&#x20;  | +------------+ |

&#x20;  | | 8-bit Adder| |

&#x20;  | +------------+ |

&#x20;  | | Logic Unit | |

&#x20;  | +------------+ |

&#x20;  | |   Shifter  | |

&#x20;  | +------------+ |

&#x20;  +----------------+

&#x20;          |

&#x20;          v

&#x20;  +-----------------+

&#x20;  | Output Registers|

&#x20;  +-----------------+

&#x20;          |

&#x20;          v

&#x20;   Result / Flags



The registered input and output stages introduce a one-clock-cycle latency while reducing the direct combinational path and improving timing predictability.



Supported Operations



The 3-bit opcode selects one of eight operations:



Opcode	Operation

000	Addition

001	Addition with carry-in

010	Bitwise AND

011	Bitwise OR

100	Bitwise XOR

101	Bitwise NOT

110	Logical left shift

111	Logical right shift



The ALU generates:



8-bit result

zero flag

carry flag

RTL Design



The design is organized hierarchically into five Verilog modules:



Module	Function

alu\_top.v	Top-level wrapper with input/output registers

alu\_core.v	Opcode decoding and ALU operation selection

adder\_8bit.v	8-bit arithmetic unit

logic\_unit.v	Bitwise logical operations

shifter.v	Left and right shift operations



The modular structure separates arithmetic, logical, and shift functionality while maintaining a synthesizable RTL architecture.



Functional Verification



Functional verification was performed as part of the RTL-to-GDSII workshop using Synopsys VCS for simulation and Verdi for waveform analysis.



Verification covered:



Clock generation

Reset initialization

Operand registration

Opcode decoding

Arithmetic operations

Logical operations

Shift operations

Carry flag behavior

Zero flag behavior

One-cycle pipeline latency



A portfolio verification testbench is included in:



testbench/ALU\_tb.v



This testbench was reconstructed from the design specification documented in the project report and is provided for functional verification of the reconstructed RTL.



RTL-to-GDSII Flow

RTL

&#x20;|

&#x20;v

Functional Verification

(VCS / Verdi)

&#x20;|

&#x20;v

Logic Synthesis

(Design Compiler)

&#x20;|

&#x20;v

SDC Constraints

&#x20;|

&#x20;v

Floorplanning

(ICC2)

&#x20;|

&#x20;v

Power Planning

&#x20;|

&#x20;v

Placement

&#x20;|

&#x20;v

Clock Tree Synthesis

&#x20;|

&#x20;v

Routing

&#x20;|

&#x20;v

Static Timing Analysis

(PrimeTime)

&#x20;|

&#x20;v

GDSII

Synthesis



Logic synthesis was performed using Synopsys Design Compiler.



The RTL was mapped to technology-specific standard cells using the SAED 32nm standard cell library.



The synthesis flow included:



Library setup and linking

RTL analysis and elaboration

SDC constraint definition

Timing-driven optimization

Quality-of-results analysis

Gate-level netlist generation



The design was synthesized with a 10 ns clock constraint corresponding to a target frequency of 100 MHz.



Physical Design



Physical implementation was performed using Synopsys IC Compiler II (ICC2).



Floorplanning



The design was initialized with a core utilization factor of 65%.



The floorplan included:



Core boundary

Placement region

I/O pin distribution

Standard-cell region

Power Planning



A power distribution network was implemented using:



Core power ring

Higher-metal power mesh

Standard-cell power rails

Placement



Timing-driven placement was performed while maintaining the 10 ns clock constraint.



Clock Tree Synthesis



Clock Tree Synthesis was performed to:



Balance clock distribution

Reduce clock skew

Control insertion delay

Maintain setup and hold timing

Routing



Timing-driven routing was performed to complete signal interconnections while satisfying timing and physical design constraints.



Antenna handling and routing optimization were also applied during the reported physical-design flow.



Static Timing Analysis



Post-route static timing analysis was performed using Synopsys PrimeTime.



The analysis used a:



Clock Period = 10 ns

Frequency    = 100 MHz



The reported analysis verified:



Setup timing

Hold timing

Critical paths

Clock behavior

Timing closure



The critical timing path was reported within the ALU arithmetic logic.



GDSII Generation



After routing and physical verification, the final layout was exported in GDSII format using IC Compiler II.



The reported flow verified:



Fully routed signal nets

Power and ground connectivity

Clock tree implementation

Timing closure

DRC cleanliness

Reported Implementation Results

Parameter	Result

Technology	SAED 32nm

Clock Period	10 ns

Frequency	100 MHz

Core Utilization	65%

Hold Violations	None

DRC Violations	0

Setup Timing	Met



The reported results indicate that the design achieved timing closure and a DRC-clean physical implementation.



Project Visuals

RTL-to-GDSII Flow



ALU Architecture



Functional Verification



Synthesis



Floorplanning



Power Planning



Placement



Clock Tree Synthesis



Routing



Post-Route Timing



Tools and Technologies

Verilog HDL

Synopsys VCS

Synopsys Verdi

Synopsys Design Compiler

Synopsys IC Compiler II

Synopsys PrimeTime

SAED 32nm

Static Timing Analysis

RTL Simulation

Logic Synthesis

Physical Design

GDSII

Repository Structure

8-bit ALU RTL-to-GDSII/

│

├── rtl/

│   ├── alu\_top.v

│   ├── alu\_core.v

│   ├── adder\_8bit.v

│   ├── logic\_unit.v

│   └── shifter.v

│

├── testbench/

│   └── ALU\_tb.v

│

├── constraints/

│   └── alu\_top.sdc

│

├── images/

│   ├── 01\_rtl\_to\_gdsii\_flow.png

│   ├── 02\_alu\_architecture.png

│   ├── 03\_verdi\_waveform.png

│   ├── 04\_synthesis\_schematic.png

│   ├── 05\_floorplan.png

│   ├── 06\_power\_plan.png

│   ├── 07\_placement.png

│   ├── 08\_cts.png

│   ├── 09\_routing.png

│   └── 10\_final\_timing.png

│

└── README.md

Project Highlights

Designed an 8-bit synchronous pipelined ALU in Verilog

Implemented modular arithmetic, logical, and shift units

Performed functional verification using VCS and Verdi

Applied timing constraints for 100 MHz operation

Performed logic synthesis using Design Compiler

Executed physical design using IC Compiler II

Worked through floorplanning, power planning, placement, CTS, and routing

Performed post-route static timing analysis using PrimeTime

Generated the final GDSII layout

Achieved reported timing closure and zero DRC violations

