# FloatMAC-P: Pipelined Floating-Point MAC Unit

A Verilog-based implementation of an IEEE-754 single-precision floating-point Multiply-Accumulate (MAC) unit for FPGA-based Digital Signal Processing (DSP) applications.

## Operation

The design performs:

**Y = (A × B) + C**

It uses modular RTL blocks and pipeline registers to organize floating-point multiplication and addition.
<img width="1774" height="887" alt="ARCHITECTURE_DIAGRAM_FLOAT POINT MAC" src="https://github.com/user-attachments/assets/71e57791-1365-4847-ae0c-41a591bb3b05" />

## Features

- IEEE-754 single-precision (32-bit) arithmetic
- Modular Verilog RTL design
- Pipelined architecture
- Dedicated unpacking, multiplication, addition, normalization, rounding, and packing blocks
- Functional and throughput simulation testing
- FPGA synthesis and timing analysis using AMD Xilinx Vivado

## Tools and Technologies

- **HDL:** Verilog
- **Tool:** AMD Xilinx Vivado
- **Target FPGA Part:** `xc7a100tcsg324-1`
- **Clock Target:** 100 MHz

## Verification Results

| Test Suite | Passed | Failed |
|---|---:|---:|
| Functional Tests | 12 | 0 |
| Throughput Tests | 7 | 0 |

## Synthesis Results

| Parameter | Result |
|---|---:|
| Slice LUTs | 1,243 |
| Slice Registers | 345 |
| DSP Blocks | 2 |
| Estimated On-Chip Power | 0.138 W |
| Worst Negative Slack | -0.886 ns |

**Note:** Timing closure at 100 MHz has not been achieved. Power figures are tool-generated estimates, not physical measurements.

## Applications

- FFT and DSP processing
- Communication signal processing
- FPGA-based arithmetic acceleration

## Author

**Suhani Gupta**  
Electronics and Communication Engineering  
ABES Engineering College, Ghaziabad

## Repository

[View Source Code on GitHub](https://github.com/HCL-ABES-3rdYear/Suhani-Gupta-FloatMAC-P)
