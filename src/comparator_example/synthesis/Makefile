# Author : Paul Capgras
# Date : Oct 2025

syn:
	make clean
	genus -f ./scripts/synthesis.tcl
	python3 ./scripts/synthesis_extract_kpi.py 

clean:
	rm -rf results/ fv/ .rs_* genus.log genus.cmd
