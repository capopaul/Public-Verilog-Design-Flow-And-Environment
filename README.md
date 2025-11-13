# A Public Verilog/Systemverilog (SV) Design Flow/Environment

## Table of content

1. [Description](#1-description)
2. [Setup](#2-setup)
    1. [Setup the Verilog Design Flow](#21-setup-the-verilog-design-flow)
    2. [Setup the Productive VS Code Environment](#22-setup-the-productive-vs-code-environment)
3. [Using the template](#3-using-the-template)
    1. [Run Simulations](#31-run-simulations)
    2. [Run Code Coverage](#32-run-code-coverage)
    3. [Run Synthesis](#33-run-synthesis)
    4. [Develop your own modules](#34-develop-your-own-modules)

## 1. Description

This repo aims to provide a basic structure to starts a Verilog or Systemverilog project.

The two main parts are a Verilog Design flow, to simulate your design easily and a Productive Visual Studio Code Environment to develop your RTL faster.

The flow include the following features:

- **Verilog Design Flow**:
  - Simulation using iverilog or modelsim
  - Waveform visualization using GTKWave form or modelsim
  - (Experimental - Modelsim flow only) Code coverage
  - (Experimental) Synthesis using Cadence Genus
- **Productive Visual Studio Code Environment**:
  - Linting: verilator and verible (warnings in your IDE)
  - Formating: verible-verilog-formating (when you save your file, the code is uniformized according to your configuration)
  - (Experimental) Language Server: verible-verilog-ls (autocompletion, go to definition/reference, ...)

## 2. Setup

### 2.1 Setup the Verilog Design Flow

#### 2.1.1. Simulation and waves visualization

Choose one between the two flow available:

- [Setup Modelsim](flow/modelsim/modelsim_flow.md) (default)
- [Setup Iverilog & GTKWave](flow/iverilog/iverilog_flow.md)

#### 2.1.2. (Experimental) Synthesis

- Install Cadence Genus.

### 2.2 Setup the Productive VS Code Environment

- install Visual Studio Code. -> to check run `code`
- install the `Verilog-HDL/SystemVerilog/Bluespec SystemVerilog` extension.
- install the `Verible Formatter` extension.
- install `verible` (download the bin files from the last release). To check run `verible-verilog-lint` should return nothing.
- install `verilator`. To check run `verilator --version`.
- the configuration file for all those extensions is available in `./.vscode/settings.json` and should be automatically read by vscode for this workspace.
- (Experimental) install `ctags` as recommended by `Verilog-HDL/SystemVerilog/Bluespec SystemVerilog` extension.

## 3. Using the template

### 3.1 Run simulations

- Open a terminal and go to `./src/` directory. It contains all the verilog modules.
- Open an example module like the adder: `cd adder_example`.
  - The `./rtl` folder contains the verilog files of this module that aims to be synthesized.
  - The `./simulation` folder contains the simulation files for the rtl code.
- Open the simulation folder: `cd simulation` and enter one test bench: `cd tb_full_behavior`.
- The default flow used is modelsim. If you want to use modelsim flow, skip this step. If you want to use iverilog & gtkwave flow, replace the makefile:
  - `rm Makefile`
  - `cp ../../../../flow/iverilog/makefile_iverilog.mak Makefile`
  - you might need to rename on the first line the test bench name.
- Execute `make run` to run the test bench.
- Execute `make rungui` to run the test bench and see the waveform with GTKwave form.
- Execute `make clean` to remove the content of the simulation cache folder (`./simulation/cache/`).

**Tips**: After running `make rungui`, the terminal is usually busy with wave visualization. If you open a second terminal and run `make run` and then click refresh or restart the simulation inside the GUI. The waves will be updated. This avoid to always open, import signal, close and restart. The command in modelsim is `restart -f; run 10ms`.

### 3.2 Run code coverage

(Experimental)

Only available if you are using the modelsim flow.

- Inside the `./simulation`, run `make coverage`
- A folder `covhtmlreport` should have been created. Open it and open with a web browser `index.html`

### 3.3 Run synthesis

(Experimental)

Simple synthesis setup is provided for Cadence Genus tool.

Inside a module folder, you can find an `rtl`, `simulation` and a `synthesis` folder. Open this `synthesis` folder and take a look at its `README.md`.

### 3.4 Develop your own modules

- To create your own module, duplicate `adder_exemple` folder.
- Rename the folder with your own name.
- Create your rtl files and test benches.
- Edit the first line of the file `src/your_module_name/simulation/tb_full_behavior/Makefile` with your new test bench name.
- if you want to create multiple test benches, duplicate the folder tb_full_behavior inside simulation.
