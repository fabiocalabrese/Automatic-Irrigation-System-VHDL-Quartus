# Automatic-Irrigation-System-VHDL-Quartus

## 🧠 Project Overview

This project implements a complete VHDL controller for an **automatic irrigation system**, developed using **Algorithmic State Machine (ASM)** methodology. It includes:

- Modular VHDL design (individual components like MUX, register file, counter)
- A full Quartus project integrating all components
- Simulation using ModelSim (including full system testbench)
- Datapath, control logic, ASM charts, and timing analysis

---

## 📁 Folder Structure

- Assignment
- diagrams: ASM Chart di controllo/algoritmica, Datapath, pseudocode and Timing.
- report: report
- VHDL_ASM: all the folders for each components (VHDL + testbench) and the folder 'IRRIGATION SYSTEM ASM' with the Full Quartus System + testbench.

---

## ⚙️ System Description

The digital system acts as a **controller for automatic irrigation**, processing 16-bit soil moisture readings from two sensors placed at 20 cm and 40 cm depths. Key tasks include:

- Reading sensor values from `DATA_IN` (via serial interface)
- Storing raw samples in memory `MEM_A` (Little Endian format)
- Calculating:
  - **Average** of both sensor values
  - **Most negative** value (maximum absolute)
- Storing results in `MEM_B`
- Raising `IRRIGATIONALARM` if 10 consecutive average values are below a fixed **stress threshold**
- Setting `DONE` at the end of processing
- Restarting only on new `START` signal

---

## 🧩 Design Details

- **ASM-based control logic**
- **Single adder datapath** (no multipliers): uses shifts + additions only
- Handles **signed data** (two's complement)
- Uses **Little Endian** memory layout
- FSM (controller) and datapath modeled separately

---

## 📐 Deliverables

- ✅ Pseudocode and datapath design
- ✅ ASM chart and control unit diagram
- ✅ Functional timing diagram
- ✅ VHDL code for each block and top-level integration
- ✅ Testbenches for all components and top-level
- ✅ ModelSim simulation results (waveforms & outputs)
- ✅ Final PDF report with design explanation and results
