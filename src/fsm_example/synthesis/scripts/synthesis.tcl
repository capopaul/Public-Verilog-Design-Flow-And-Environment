# Author : Paul Capgras
# Date : Nov 2025

################################################################################
# Preset global variables and attributes
################################################################################

set OUTPUTS_PATH results/outputs
set REPORTS_PATH results/reports
set LOG_PATH results/logs
set FV_PATH results/fv

if {![file exists ${LOG_PATH}]} {
  file mkdir ${LOG_PATH}
  puts "Creating directory ${LOG_PATH}"
}

if {![file exists ${OUTPUTS_PATH}]} {
  file mkdir ${OUTPUTS_PATH}
  puts "Creating directory ${OUTPUTS_PATH}"
}

if {![file exists ${REPORTS_PATH}]} {
  file mkdir ${REPORTS_PATH}
  puts "Creating directory ${REPORTS_PATH}"
}

set_db init_hdl_search_path {. ./scripts}
set_db script_search_path {. ./scripts}

source ./scripts/config.tcl

################################################################################
# load the library
################################################################################

set_db library $LIB_FILES


################################################################################
# load and elaborate the design
################################################################################

# Read Verilog files if any
if { [info exists VERILOG_FILES] && [string length $VERILOG_FILES] > 0 } {
    read_hdl -language v2001 $VERILOG_FILES
}
# Read SystemVerilog files if any
if { [info exists SV_FILES] && [string length $SV_FILES] > 0 } {
    read_hdl -language sv $SV_FILES
}

elaborate $DESIGN
time_info Elaboration
check_design -unresolved


################################################################################
# specify timing and design constraints
################################################################################

read_sdc $SDC_FILE

# set_db / .lp_insert_clock_gating false

check_timing_intent


################################################################################
# synthesize the design to generic
################################################################################

# configure effort
set_db / .syn_generic_effort medium

# run the synthesis to generic gates
syn_generic

# save the generic netlist
write_hdl > ${OUTPUTS_PATH}/${DESIGN}_generic.v

time_info GENERIC

# save reports
report_dp > $REPORTS_PATH/generic/${DESIGN}_datapath.rpt
write_snapshot -outdir $REPORTS_PATH/generic/ -tag generic
report_summary -directory $REPORTS_PATH/generic/


################################################################################
# synthesize the design to gates
################################################################################

# configure effort
set_db / .syn_map_effort high

# run the synthesis to technology gates
syn_map

# save the technology mapped netlist
write_hdl > ${OUTPUTS_PATH}/${DESIGN}_map.v

time_info MAPPED

# save reports
write_snapshot -outdir $REPORTS_PATH/map/ -tag map
report_summary -directory $REPORTS_PATH/map/
report_dp > $REPORTS_PATH/map/${DESIGN}_datapath.rpt


################################################################################
# Optimize Netlist
################################################################################

# configure effort
set_db / .syn_opt_effort high

# run the synthesis optimization to reach lower power&area that meets performance requirements
syn_opt

time_info OPT

# save reports
write_snapshot -outdir $REPORTS_PATH/syn_opt/ -tag syn_opt
report_summary -directory $REPORTS_PATH/syn_opt/


################################################################################
# analyze design                     
################################################################################

# report_area
# report_timing
# report_gates


################################################################################
# export design
################################################################################

# save final netlist
write_hdl  > ${OUTPUTS_PATH}/${DESIGN}_m.v

# save final sfc
write_sdc > ${OUTPUTS_PATH}/${DESIGN}_m.sdc

write_script > ${OUTPUTS_PATH}/${DESIGN}_m.script

# save final reports
report_dp > $REPORTS_PATH/${DESIGN}_datapath_incr.rpt
report_messages > $REPORTS_PATH/${DESIGN}_messages.rpt
write_snapshot -outdir $REPORTS_PATH -tag final
report_summary -directory $REPORTS_PATH

# Report power
report_power > $REPORTS_PATH/${DESIGN}_power.rpt

# move logs to the log folder
file rename [get_db / .stdout_log] ${LOG_PATH}/genus.log
file rename genus.cmd ${LOG_PATH}/genus.cmd

# move fv folder (created by elaboration) into results folder
file rename fv $FV_PATH

puts "============================"
puts "Synthesis Finished ........."
puts "============================"

quit
