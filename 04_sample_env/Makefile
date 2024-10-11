.PHONY: all
all: build run

# SRCS += model/sample_env.sv
# SRCS += sample_test.sv
SRCS += tb_top.sv
TOP_MODULE += tb_top

.PHONY: build
build:
	xvlog -sv $(SRCS) -L uvm --include ./model
	xelab $(TOP_MODULE) -L uvm -timescale 1ns/1ps

.PHONY: run
run:
	xsim $(TOP_MODULE) -R --testplusarg "UVM_TESTNAME=sample_test" # -testplusarg "UVM_VERBOSITY=UVM_LOW" -uvm_version 1.1

.PHONY: clean
clean:
	rm -rf *.log *.jou *.pb xsim.dir
