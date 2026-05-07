# ADPLL_Project

**All-Digital Phase-Locked Loop (ADPLL) — Verilog RTL Design**

This project implements an **All-Digital Phase-Locked Loop (ADPLL)** using Verilog HDL and HSPICE simulation methodology,
with emphasis on modular digital PLL architecture and verification flow.

The ADPLL is composed of:

- Digitally Controlled Oscillator (DCO)
- Phase Frequency Detector (PFD)
- Digital Loop Filter (DLF)
- Controller
- Frequency Divider

After completing the design, the functionality of the ADPLL was verified through behavioral simulation and AMS simulation.


---

# Table of Contents

- [Repository Layout](#repository-layout)
- [Architecture](#architecture)
  - [ADPLL Overview](#adpll-overview)
  - [Building Blocks](#building-blocks)
- [Implementation Status](#implementation-status)
  - [Implemented](#implemented)
  - [Future Improvements](#future-improvements)
- [Simulation & Verification](#simulation--verification)
  - [Verification Flow](#verification-flow)
  - [Simulation Result](#simulation-result)
- [Reference](#reference)


---

# Repository Layout

```text
rtl/
 ├─ pfd/                  # Phase Frequency Detector
 ├─ dco/                  # Digitally Controlled Oscillator
 ├─ filter/               # Digital Loop Filter
 ├─ controller/           # FSM / control logic
 ├─ divider/              # Frequency divider
 └─ top/                  # ADPLL top-level integration

tb/
 └─ tb.v                  # Top-level testbench

sim/
 ├─ behavioral/           # Behavioral simulation
 └─ ams/                  # AMS simulation

waveform/
 └─ Simulation waveforms

img/
 └─ Architecture diagrams
```


---

# Architecture

The ADPLL is implemented as a modular digital PLL architecture,
with independent functional blocks for frequency tracking and clock synchronization.


## ADPLL Overview

![ADPLL](img/adpll_architecture.png)

The ADPLL architecture consists of:

- Phase Frequency Detector (PFD)
- Controller
- Digital Loop Filter (DLF)
- Digitally Controlled Oscillator (DCO)
- Frequency Divider


### Signal Flow

```text
Reference Clock
       │
       ▼
+----------------+
|      PFD       |
+----------------+
       │
       ▼
+----------------+
|   Controller   |
+----------------+
       │
       ▼
+----------------+
| Digital Filter |
+----------------+
       │
       ▼
+----------------+
|      DCO       |
+----------------+
       │
       ▼
   Output Clock
       │
       ▼
+----------------+
| Frequency Div. |
+----------------+
       │
       └──────────── Feedback
```


## Building Blocks


### Phase Frequency Detector (PFD)

The PFD compares:

- Reference clock
- Feedback clock

and generates phase correction signals.


### Controller

The controller adjusts the DCO control code according to phase error information.

Features：

- FSM-based control
- Frequency tracking
- Lock-state control


### Digital Loop Filter (DLF)

The digital loop filter smooths the control signal to improve locking stability and reduce oscillation.


### Digitally Controlled Oscillator (DCO)

The DCO generates the output clock according to the control code.


### Frequency Divider

The divider generates the feedback clock used for PLL synchronization.


---

# Implementation Status


## Implemented

- ✔ Modular ADPLL architecture
- ✔ Phase Frequency Detector (PFD)
- ✔ Digital Loop Filter (DLF)
- ✔ FSM-based controller
- ✔ Digitally Controlled Oscillator (DCO)
- ✔ Frequency divider
- ✔ Behavioral simulation
- ✔ AMS simulation verification


## Future Improvements

- Fractional-N PLL support
- Faster lock-time optimization
- Improved jitter performance
- Gate-level simulation
- Synthesis & APR flow


---

# Simulation & Verification

The ADPLL functionality is verified through behavioral simulation and AMS simulation.


## Verification Flow

```text
Architecture Design
        ↓
RTL Design
        ↓
Behavioral Simulation
        ↓
AMS Simulation
        ↓
Waveform Verification
```


## Simulation Result

The following behaviors were verified：

- Frequency locking
- Clock synchronization
- Stable feedback operation
- Output clock convergence


### Waveform Analysis

Simulation waveforms were analyzed to verify：

- PLL lock behavior
- Frequency convergence
- Output clock stability
- Feedback synchronization


---

# Reference

[1] ADPLL Architecture Reference  
[2] Digital PLL Design Methodology  
[3] Verilog RTL Design  