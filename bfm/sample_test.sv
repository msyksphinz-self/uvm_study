`timescale 1ps/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

class sample_test extends uvm_test;
  `uvm_component_utils(sample_test);
  sample_env env;

  function new (string name="sample_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    uvm_config_db#(uvm_object_wrapper)::set(this,
       "env.agent.sequencer.run_phase", "default_sequence",
       issue_one_trans_seq::type_id::get());
    env = sample_env::type_id::create("env", this);
  endfunction // build_phase

  task run_phase (uvm_phase phase);
    uvm_top.print_topology();
  endtask // run_phase

endclass // sample_test
