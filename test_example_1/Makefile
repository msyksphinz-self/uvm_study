.PHONY: all
all: build run

SRCS += tb_top.sv
SRCS += reg_if.sv
SRCS += src/reg_ctrl.sv
TOP_MODULE += tb_top

TESTNAME = test

.PHONY: build
build:
	xvlog -sv $(SRCS) -L uvm --include ./model --include ./tb -uvm_version 1.2
	xelab $(TOP_MODULE) -L uvm -timescale 1ns/1ps -uvm_version 1.2

.PHONY: run
run:
	xsim $(TOP_MODULE) --R --testplusarg "UVM_TESTNAME=$(TESTNAME)" --testplusarg "UVM_CONFIG_DB_TRACE"

export DSIM_HOME=/home/msyksphinz/metrics-ca/dsim/20240923.0.0/
export DSIM_LICENSE=$(HOME)/metrics-ca/dsim-license.json

.PHONY: dsim_run
dsim_run:
	dsim -top work.tb_top -genimage image -uvm 1.2 +incdir+model +incdir+tb $(SRCS) +acc+b
	dsim -image image -uvm 1.2 -waves waves.mxd +UVM_NO_RELNOTES +UVM_TESTNAME=$(TESTNAME)

.PHONY: clean
clean:
	rm -rf *.log *.jou *.pb xsim.dir
