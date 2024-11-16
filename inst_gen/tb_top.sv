// `timescale 1ps/1ps

module tb_top;

// UVM class library
`include "uvm_macros.svh"
import uvm_pkg::*;

// uvm user code
`include "inst_gen_model.svh"

`include "test.sv"

/////////////////////////////////////
logic clk;
inst_gen_if vif(clk);
// clk
initial begin
  clk <= 1'b1;
  #100;
  forever #50 clk <= ~clk;
end

initial begin
  uvm_config_db #(virtual inst_gen_if)::set(uvm_root::get(), "*", "inst_gen_vif", vif);

  run_test();
  $finish;
end

`ifdef VCS
initial begin
  $fsdbDumpfile ("novas.fsdb");
  $fsdbDumpvars (0, tb_top);
end
`endif // VCS

endmodule // tb_top
