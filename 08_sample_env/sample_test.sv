`timescale 1ps/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

class sample_test extends uvm_test;

  `uvm_component_utils(sample_test)
  tb_env env;

  function new (string name="sample_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db #(uvm_object_wrapper)::set(this,
      "env.sample_model.master.sequencer.run_phase", "default_sequence",
      write_read_seq::type_id::get()
      );
    uvm_config_db #(uvm_object_wrapper)::set(this,
      "env.sample_model.slave.sequencer.run_phase",  "default_sequence",
      normal_response_seq::type_id::get()
      );
    env = tb_env::type_id::create("env", this);
  endfunction // build_phase

  task run_phase(uvm_phase phase);
    uvm_report_info("TEST", "Hello World");
    uvm_top.print_topology();
  endtask // run_phase

endclass // sample_test
