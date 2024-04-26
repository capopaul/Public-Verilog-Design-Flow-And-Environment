tb_file_name = tb_full_behavior
run:
	if [ ! -d "./cache/" ]; then \
  		mkdir ./cache; \
	fi;\
	iverilog -o ./cache/$(tb_file_name).vvp $(tb_file_name).v;\
	vvp ./cache/$(tb_file_name).vvp;

rungui:
	make run;\
	gtkwave ./cache/$(tb_file_name).vcd;

clean:
	if [ -d "./cache/" ]; then \
  		rm -r ./cache; \
	fi;
