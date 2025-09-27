tb_file_name = tb_edge_case
work_dir = ./cache

run:
	@if [ ! -d $(work_dir) ]; then \
		vlib $(work_dir); \
	fi
	vmap work $(work_dir)
	vlog $(tb_file_name).v +acc=rnpc -lint

rungui:
	make run;\
	vsim work.$(tb_file_name) -do "add wave /*; run -all;"

clean:
	rm -rf $(work_dir) transcript vsim.wlf
