# Author : Paul Capgras
# Date : Oct 2025

# top level module name
set DESIGN comparator

# technology path
set LIB_FILES path_to_lib.lib

# list paths to all your hdl files. Order does matter.
set VERILOG_FILES {\
    ../../rtl/comparator_example.v \
}
set SV_FILES {}

# list paths to all sdc files.
set SDC_FILE ./sdc/constraint.sdc
