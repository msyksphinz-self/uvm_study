.PHONY: all
all: build run

SRCS += tb_top.sv
SRCS += sample_if.sv
TOP_MODULE += tb_top

.PHONY: build
build:
	xvlog -sv $(SRCS) -L uvm --include ./model # -uvm_version 1.1
	xelab $(TOP_MODULE) -L uvm -timescale 1ns/1ps # -uvm_version 1.1

.PHONY: run
run:
	xsim $(TOP_MODULE) --R --testplusarg "{ UVM_TESTNAME=sample_test }"

.PHONY: clean
clean:
	rm -rf *.log *.jou *.pb xsim.dir
