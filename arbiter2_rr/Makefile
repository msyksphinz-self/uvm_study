.PHONY: all
all: build run

SRCS += model/arbiter2_rr_if.sv
SRCS += tb_top.sv
SRCS += src/arbiter2_rr.sv
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
	dsim -image image -uvm 1.2 -waves waves.mxd -sv_seed random +UVM_NO_RELNOTES +UVM_TESTNAME=$(TESTNAME)

VCS_OPTIONS += +define+VCS
VCS_OPTIONS += +incdir+./model
VCS_OPTIONS += -ntb_opts uvm
VCS_OPTIONS += -l vcs.log
VCS_OPTIONS += -kdb
VCS_OPTIONS += -full64
VCS_OPTIONS += -sverilog
VCS_OPTIONS += -top tb_top
VCS_OPTIONS += $(SRCS)
VCS_OPTIONS += +fsdb+all
VCS_OPTIONS += -debug_access+all
VCS_OPTIONS += +lint=PCWM

.PHONY: vcs build_vcs run_vcs run_verdi
vcs: build_vcs run_vcs
build_vcs:
	vcs $(VCS_OPTIONS)

run_vcs:
	./simv -l simv.log +UVM_TESTNAME=$(TESTNAME)

run_verdi:
	verdi -ssf ./novas.fsdb

.PHONY: clean
clean:
	rm -rf *.log *.jou *.pb xsim.dir
