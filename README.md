# pipelined_alu

# FPGA-Based Parameterized Pipelined ALU with Static Timing Analysis (STA)

## Overview

This project implements a parameterized pipelined Arithmetic Logic Unit (ALU) in Verilog HDL and demonstrates Static Timing Analysis (STA)-driven RTL optimization using Xilinx Vivado.

The design was synthesized for the Xilinx Zynq-7000 FPGA architecture, and timing performance was evaluated by progressively tightening clock constraints and optimizing the RTL pipeline.

The project focuses on RTL design, synthesis, and timing analysis. Hardware implementation on a physical FPGA board was not performed.

---

## Features

- Parameterized 32-bit ALU
- Multi-stage pipelined architecture
- Supported operations
  - Addition
  - Subtraction
  - AND
  - OR
  - XOR
- Static Timing Analysis (STA)
- Timing-driven RTL optimization
- FPGA synthesis using Xilinx Vivado
- Parameterizable data width

---

## Hardware & Tools

- FPGA : ZedBoard (Xilinx Zynq-7000 XC7Z020)
- Tool : Xilinx Vivado 2016.4
- Language : Verilog HDL

---

## Directory Structure

```
Parameterized-Pipelined-ALU/
│
├── rtl/
│   ├── alu_pipelined.v
│   ├── alu_pipelined_deep.v
│   └── alu_clock.xdc
│
├── timing_reports_sta/
│   ├── alu_pipelined/
│   │   ├── timing_100MHz.png
│   │   ├── timing_200MHz.png
│   │   └── timing_300MHz.png
│   │
│   └── alu_pipelined_deep/
│       ├── timing_300MHz.png
│       ├── timing_330MHz.png
│       ├── timing_337MHz.png
│       ├── timing_340MHz.png
│       └── timing_400MHz.png
│
├── FPGA_Pipelined_ALU_Timing_Report.docx
│
└── README.md
```

---

## Pipeline Architecture

### Initial Design

```
Input Registers
      │
      ▼
Complete ALU
(Add/Sub/Logic + MUX)
      │
      ▼
Output Register
```

### Optimized Design

```
Stage 1
Input Registers
      │
      ▼
Stage 2
Parallel Arithmetic & Logic
      │
      ▼
Stage 3
Operation Selection
      │
      ▼
Stage 4
Output Register
```

The optimized pipeline reduces combinational logic depth, improving synthesis timing performance.

---

## RTL Optimization Process

The optimization methodology followed in this project:

```
Design RTL

↓

Run Synthesis

↓

Apply Clock Constraint

↓

Analyze WNS & TNS

↓

Increase Clock Frequency

↓

Timing Violation?

↓

YES

↓

Identify Critical Timing Path

↓

Increase Pipeline Depth

↓

Re-run Synthesis

↓

Repeat Until Timing Closure
```

---

## Results

- Successfully synthesized for the Xilinx Zynq-7000 FPGA architecture
- Performed post-synthesis Static Timing Analysis
- Evaluated timing under multiple clock constraints
- Optimized RTL pipeline to achieve timing closure at 300 MHz
- Demonstrated approximately 40% improvement in estimated maximum operating frequency after RTL optimization

---

## Concepts Demonstrated

- Verilog RTL Design
- Parameterized Modules
- FPGA Synthesis
- Static Timing Analysis (STA)
- Worst Negative Slack (WNS)
- Total Negative Slack (TNS)
- Critical Path Optimization
- Pipeline Design
- Clock Constraints
- Timing Closure Methodology

---
