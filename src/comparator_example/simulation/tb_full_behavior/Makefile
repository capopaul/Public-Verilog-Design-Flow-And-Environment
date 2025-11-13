tb_file_name = tb_full_behavior
work_dir = ./cache

run:
	@if [ ! -d $(work_dir) ]; then \
		vlib $(work_dir); \
	fi
	vmap work $(work_dir)

# 	'+acc' is for accessibility. It enables signal access for debugging
#     'r' for register acess
#     'n' for net access
#     'p' for port access
#    '-cover' enables code coverage
#     'b' for blocks
#     'c' for conditions
#     'e' for expressions
#     's' for statements
#     't' for toggles
#     'f' for FSMs  

	vlog $(tb_file_name).v +acc=rnpc -lint -cover bcestf

rungui:
	make run;\
	vsim work.$(tb_file_name) -do simulation.tcl

clean:
	rm -rf $(work_dir) transcript vsim.wlf coverage_report.ucdb covhtmlreport

coverage:
	make run;\
	vsim work.$(tb_file_name) -do simulation.tcl -c -coverage
	rm -rf covhtmlreport
	vcover report -details -html coverage_report.ucdb
