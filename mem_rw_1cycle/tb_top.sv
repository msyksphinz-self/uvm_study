// `timescale 1ps/1ps

module tb_top;

// UVM class library
`include "uvm_macros.svh"
import uvm_pkg::*;

// uvm user code
`include "mem_rw_model.svh"

`include "test.sv"

/////////////////////////////////////
logic clk;
mem_rw_if vif(clk);
// clk
initial begin
  clk <= 1'b1;
  #100;
  forever #50 clk <= ~clk;
end

mem_rw u0
  (
   .i_clk     (clk),

   .i_valid (vif.i_valid),
   .i_addr  (vif.i_addr ),
   .i_rw    (vif.i_rw   ),
   .i_data  (vif.i_data ),

   .o_data  (vif.o_data )
   );


initial begin
  uvm_config_db #(virtual mem_rw_if)::set(uvm_root::get(), "*", "mem_rw_vif", vif);

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
