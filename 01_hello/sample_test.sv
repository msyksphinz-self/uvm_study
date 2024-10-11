`timescale 1ps/1ps

module tb_top;
  `include "uvm_macros.svh"
  import uvm_pkg::*;

class sample_test extends uvm_test;
  `uvm_component_utils(sample_test)
  function new (string name="sample_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  task run_phase(uvm_phase phase);
    uvm_report_info("TEST", "Hello World");
  endtask
endclass

initial begin
  run_test("sample_test");
end

endmodule
