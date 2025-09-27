# Design Specification

## Revision History

| Revision |       Date        |    Author    |  Comments   |
| -------- | :---------------: | :----------: | :---------: |
| 0.1      | Sept 27, 2025  | Paul Capgras | First draft |

## Reference Documents

| Doc ID |  From   | Title | Version and date |
| ------ | :-----: | :---: | :--------------: |
| [AD1]  |         |       |                  |

## Table of Content

1. [Introduction](#1-introduction)
    1. [Purpose](#11-purpose)
    2. [Audience](#12-audience)
    3. [Definitions](#13-definitions)
    4. [Overview & features](#14-overview--features)
2. [HW interface](#2-hw-interface)
    1. [HW parameters](#21-hw-parameters)
    2. [HW signals](#22-hw-signals)
3. [Functional description](#3-functional-description)
    2. [Architectures](#32-architectures)
    3. [Block Description](#33-block-description)
4. [Clock and reset](#4-clock-and-reset)
    1. [Clock](#41-clock)
    2. [Reset](#42-reset-signal-reset-signal)
5. [Verification & Integration](#5-verification)
    1. [Verification Plan](#51-verification-plan)
    2. [DFT](#52-dft--design-for-test)
    3. [Wiring & debug](#53-wiring--debug)
6. [Integration](#6-integration)
7. [FW interface](#7-fw-interface)
    1. [Usage](#71-usage)
        1. [Initiliatilization procedures](#711-initialization-procedures)
        2. [Run time procedures](#712-run-time-procedures)
        3. [Interrupt events and FW expected actions](#713-interrupt-events-and-fw-expected-actions)
    2. [Programming Model](#72-programming-model)
8. [PPA results](#8-ppa-results)
    1. [Power consumption](#81-power-consumption)
    2. [Performance](#82-performance)
    3. [Area](#83-area)
9. [Appendix](#9-appendix)
    1. [HW parameter default value decision record](#91-hw-parameter-default-value-decision-record)

## 1. Introduction

### 1.1 Purpose

### 1.2 Audience

### 1.3 Definitions

- CSR: Configuration and Status Registers
- IRQ = Interrupt Request line
- Active = High level signal = b1 = enabled
- Low = disabled = b0
- Register are always 32bits unless said otherwise
- FW = firmware
- CDC = Clock Domain Crossing
- DR = Design requirements

### 1.4 Overview & Features

## 2. HW interface

### 2.1 HW parameters

| Parameter name | Default value | Allowed value(s) | Description |
| -------------- | :-----------: | :--------------: | :---------: |
| bus_size       |       8       |           16     | bus sizer   |

### 2.2 HW signals

The following table describes the signals being part of the HW interface.

| Group  | Signal name         | Direction |  Width (bits)  | Reset state | Description |
| ------ | ------------------- | :-------: | :------------: | :---------: | :---------: |
| reset  | arstn               |   input   |       1        |     N/A     |   reset     |

## 3. Functional description

### 3.1 Design Requirements (DR)

| DR | Requirements |
|----|--------------|
|1.1 | This IP shall ... |

### 3.2 Architectures

Insert here drawio diagram.

### 3.3 Block description

Describe here each block of the drawio diagram.

<!--
############################################################################

Clock and Reset Strategy

############################################################################
-->

## 4. Clock and reset

### 4.1 Clock

| Clock Domain             | Clock Name         | Direction | Description | Default Value | Accepted Value |
| ------------------------ | ------------------ | --------- | ----------- | ------------- | -------------- |
| Main clock domain        | clock              | Input     | My main clock | 10MHz       | <100MHz        |

### 4.2 Reset Signal {#reset-signal}

| Reset Signal Name | Direction | Description |
| ----------------- | --------- | ----------- |
| arstn             | Input     | Asynchronous Active Low Reset to reset the IP |

**[Warning]** Don't forget to describe the reset procedure.

<!--
############################################################################

Test Strategy

############################################################################
-->

## 5. Verification

### 5.1 Verification Plan

Check [Verification Plan](./verification_plan.md).

### 5.2 DFT : Design for test

All flip flops are scannable?
Internal clock?
Internal reset?
Gated clock?
Ram or memory?

### 5.3 Wiring & debug

Are they wiring/debug registers?

## 6. Integration

## 7. FW interface

### 7.1 Usage

#### 7.1.1 Initialization procedures

#### 7.1.2 Run time procedures

#### 7.1.3 Interrupt events and FW expected actions

The following table lists all interrupt events and the expected FW actions.

| Interrupt event name | Event description | Expected FW action |
| -------------------- | ----------------- | ------------------ |
| irq_data | new data available | read register |

### 7.2 Programming model

## 8. PPA results

Results are using TSMC 180 nm sandard cells, 1 gate = NAND2 drive 1.

### 8.1 Power consumption

The IP has the following power consumption:

- Leakage: x W

- Dynamic: x W with a FHz clock and 10% toggle activities.

### 8.2 Performance

- The clock can work up to FHz.

### 8.3 Area

The IP area for the logic part is X kgates for the configuration : X, X.

## 9. Appendix

### 9.1 HW parameter default value decision record
