`timescale 1ps/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

// `define set_seq(INST,SEQ) \
//   uvm_config_db#(uvm_object_wrapper)::set(this,`"INST`","default_sequence",SEQ::type_id::get());
//
// `define uvm_test_head(NAME) \
//   class NAME extends sample_test_base; \
//     `uvm_component_utils(NAME) \
//     function new (string name=`"NAME`", uvm_component parent=null); \
//       super.new(name,parent); \
//     endfunction

// virtual class sample_test_base extends uvm_test;
//   `uvm_component_utils(sample_test_base)
//   tb_env env;
//
//   function new (string name="sample_test_base", uvm_component parent=null);
//     super.new (name, parent);
//   endfunction // new
//
//   function void build_phase(uvm_phase phase);
//     super.build_phase(phase);
//     env = tb_env::type_id::create("env", this);
//   endfunction // build_phase
//
//   task run_phase(uvm_phase phase);
//     uvm_report_info("TEST", "Hello World");
//     uvm_top.print_topology();
//   endtask // run_phase
//
// endclass // sample_test_base

// `uvm_test_head(sample_test)
//   function void build_phase(uvm_phase phase);
//     `set_seq(tb.sample_model.master.sequencer.run_phase, write_read_seq)
//     `set_seq(tb.sample_model.slave.sequencer.run_phase,  normal_response_seq)
//     super.build_phase(phase);
//   endfunction
// endclass
//
// `uvm_test_head(sample_test_write_read_all_req)
//   function void build_phase(uvm_phase phase);
//     `set_seq(tb.sample_model.master.sequencer.run_phase, write_read_all_seq)
//     `set_seq(tb.sample_model.slave.sequencer.run_phase,  random_response_seq)
//     super.build_phase(phase);
//   endfunction
// endclass

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


class sample_test_write_read_all_seq extends uvm_test;

  `uvm_component_utils(sample_test_write_read_all_seq)
  tb_env env;

  function new (string name="sample_test_write_read_all_seq", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db #(uvm_object_wrapper)::set(this,
      "env.sample_model.master.sequencer.run_phase", "default_sequence",
      write_read_all_seq::type_id::get()
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

endclass // sample_test_write_read_all_seq
