# A Public Verilog Design Flow/Environment

## Description
This repo aims to provide a basic structure to starts a verilog project. The two main parts are:
- A **Verilog Design Flow**: Simulation and WaveForm Visualization
    - simulation using iverilog
    - waveform visualization using GTKWave form
- A productive **Visual Studio Code Environment**
    - Linting: verilator and verible (warnings in your IDE)
    - Formating: verible-verilog-formating (when you save your file, the code is uniformized according to your configuration)
    - Language Server: verible-verilog-ls (autocompletion, go to definition/reference, ...) 

## Setup the Verilog Deisgn Flow
- install Make     -> to check run `make -v`
- install iverilog -> to check run `iverilog -v`
- install GTKWave  -> to check run `gtkwave -v`

## Setup VS code 
- install Visual Studio Code. -> to check run `code`
- install the `Verilog-HDL/SystemVerilog/Bluespec SystemVerilog` extension.
- the description of the extension asks to install `ctags` so do it.
- install the `Verible Formatter` extension.
- install `verible` (download the bin files from the last release). To check run `verible-verilog-lint` should return nothing.
- install `verilator`. To check run `verilator --version`.
- the configuration file for all those extensions is available in `./.vscode/settings.json` and should be automatically read by vscode for this workspace.

## Run
- Open a terminal and go to `./src/` directory. It contains all the verilog modules.
- Open the example module `cd adder_example`.
- The `./rtl` folder contains the behavior verilog files of the module.
- The `./simulation` folder contains the simulation file for the rtl code. Open it `cd simulation`.
- Execute `make run` to run the test bench.
- Execute `make rungui` to run the test bench and see the waveform with GTKwave form.
- Execute `make clean` to remove the content of the simulation cache folder (`./simulation/cache/`).

## Using the template
- To create your own module, duplicate `adder_exemple` folder.
- Rename the folder with your own name.
- Create your rtl files and test benches.
- Edit the first line of the file `src/your_module_name/simulation/tb_full_behavior/Makefile` with your new test bench name.
- if you want to create multiple test benches, duplicate the folder tb_full_behavior inside simulation.

- After running `make rungui`, the terminal is usually busy with GTKwave. If you open a second terminal and run `make run` and then click refresh inside GTKwave gui the waves will be updated. This avoid to always open, import signal, close and restart.
