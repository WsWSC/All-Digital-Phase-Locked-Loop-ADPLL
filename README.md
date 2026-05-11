# All-Digital Phase-Locked Loop (ADPLL)

This project implements an **All-Digital Phase-Locked Loop (ADPLL)** using Verilog HDL and HSPICE simulation methodology.

The ADPLL architecture consists of:

- Phase Frequency Detector (PFD)
- Digital Pulse Amplifier (DPA)
- PLL Controller
- Digitally Controlled Oscillator (DCO)
- Frequency Divider

The functionality of the ADPLL was verified through:

- Behavioral Simulation
- AMS Mixed-Mode Simulation

<br>


# Table of Contents

- [Specifications](#specifications)

- [Repository Layout](#repository-layout)

- [Architecture](#architecture)
  - [ADPLL Overview](#-adpll-overview)
  - [Phase Frequency Detector (PFD)](#-phase-frequency-detector-pfd)
  - [Digital Pulse Amplifier (DPA)](#-digital-pulse-amplifier-dpa)
  - [PLL Controller](#-pll-controller)
  - [Digitally Controlled Oscillator (DCO)](#-digitally-controlled-oscillator-dco)
  - [Frequency Divider](#-frequency-divider)

- [Simulation & Verification](#simulation--verification)
  - [Verification Flow](#verification-flow)

- [Simulation Result](#simulation-result)
  - [U18 Process Result](#u18-process-result)
  - [ADFP 16nm Process Result](#adfp-16nm-process-result)

- [Mixed-Mode Simulation](#mixed-mode-simulation)

- [Tools & Environment](#tools--environment)

<br>


# Specifications

| Item | Description |
|---|---|
| Target Process | UMC 180nm / TSMC ADFP 16nm |
| Reference Clock | 37.1 MHz ~ 14.94 GHz |
| Output Clock | 259.4 MHz ~ 14.94 GHz |
| Divider Ratio | M = 1 ~ 7 |
| Lock Time | 8 ~ 62 cycles |
| Verification | Behavioral + AMS Simulation |

<br>


# Repository Layout

```text
rtl/
 ├─ ADPLL.v
 ├─ CONTROLLER.v
 ├─ DCO.v
 ├─ FREQ_DIV.v
 ├─ PFD.v
 └─ RESET_INV.v

tb/
 ├─ tb_top.v
 ├─ tb_lock.v
 └─ tb_freq_sweep.v

spice/
 ├─ DCO.sp
 └─ PFD.sp

scripts/
 ├─ period_jitter.py
 └─ cycle_to_cycle_jitter.py

img/
 └─ Architecture / waveform images
```

<br>


# Architecture

## 🔹 ADPLL Overview

<p align="center">
  <img src="img/Architecture_ADPLL.png" width="700"/>
</p>

The ADPLL architecture consists of:

- PFD + DPA
- PLL Controller
- Digitally Controlled Oscillator (DCO)
- Frequency Divider

<br>


## 🔹 Phase Frequency Detector (PFD)

<p align="center">
  <img src="img/Architecture_PFD.png" width="650"/>
</p>

The PFD is implemented using a cell-based tri-state Bang-Bang architecture.

It compares:

- Reference clock
- Feedback clock

and generates `flagU` / `flagD` signals for ADPLL locking behavior.

<br>


## 🔹 Digital Pulse Amplifier (DPA)

<p align="center">
  <img src="img/Architecture_DPA.png" width="650"/>
</p>

The DPA is implemented using a multi-stage digital delay chain.

It amplifies and aligns pulse signals to improve phase tracking stability.

<br>


## 🔹 PLL Controller

<p align="center">
  <img src="img/Architecture_Controller.png" width="650"/>
</p>

The controller adjusts the DCO control code according to phase error information.

Features:

- Frequency tracking
- FSM-based control
- Lock-state control
- Loop filter assisted convergence

<br>


## 🔹 Digitally Controlled Oscillator (DCO)

<p align="center">
  <img src="img/Architecture_DCO.png" width="650"/>
</p>

The DCO generates the output clock according to the digital control code.

The oscillation frequency is adjusted using tri-state buffer based delay stages with binary-weighted control.

Features:

- Digitally controlled frequency tuning
- Fully digital architecture
- Binary-weighted delay control
- Clock generation for ADPLL feedback loop

<br>


## 🔹 Frequency Divider

The divider generates the feedback clock used for PLL synchronization.

A programmable counter-based divider is used for frequency division ratio:

```text
M = 1 ~ 7
```

<br>


# Simulation & Verification

## Verification Flow

```text
RTL Design
    ↓
Behavioral Simulation
    ↓
AMS Mixed-Mode Simulation
    ↓
Waveform Verification
    ↓
Jitter Measurement
```

<br>


# Simulation Result

## U18 Process Result

| Item | Result |
|---|---|
| Output Frequency | 259.4 MHz ~ 1333.3 MHz |
| Lock Time | 8 ~ 21 cycles |
| Period Jitter | 0.562 ns |
| Cycle-to-Cycle Jitter | 0.582 ns |
| Avg Power | 3.628 mW |

<br>


## ADFP 16nm Process Result

| Item | Result |
|---|---|
| Output Frequency | 4.514 GHz ~ 14.94 GHz |
| Lock Time | 21 ~ 62 cycles |
| Period Jitter | 3.120 ps |
| Cycle-to-Cycle Jitter | 3.480 ps |
| Avg Power | 1.119 mW |

<br>


# Mixed-Mode Simulation

The Verilog behavioral models:

- `DCO.v`
- `PFD.v`

were replaced with SPICE-level implementations:

- `DCO.sp`
- `PFD.sp`

to perform AMS mixed-mode simulation.

<br>


# Tools & Environment

- Verilog HDL
- HSPICE
- Cadence ADE-L
- Synopsys VCS
- Synopsys XA
- AMS Mixed-Mode Simulation