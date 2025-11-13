# Author: Paul Capgras
# Date : Oct 2025

log -r /*

# coverage exclude -srcfile myfile.sv
coverage save -onexit coverage_report.ucdb

# run 800 us
run -all;
