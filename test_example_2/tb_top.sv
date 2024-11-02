`timescale 1ps/1ps

module tb_top;

// UVM class library
`include "uvm_macros.svh"
import uvm_pkg::*;

// uvm user code
`include "model.svh"

`include "test.sv"

/////////////////////////////////////
logic clk, rstz;
switch_if vif(clk);
// clk
initial begin
  clk <= 1'b1;
  #100;
  forever #50 clk <= ~clk;
end

// rstz
initial begin
  rstz     <= 1'b0;
  #80 rstz <= 1'b1;
end

switch u0
  (
   .clk   (clk ),
   .rstn  (vif.rstn ),
   .vld   (vif.vld  ),

   .addr (vif.addr ),
   .data (vif.data ),

   .addr_a (vif.addr_a ),
   .data_a (vif.data_a ),
   .addr_b (vif.addr_b ),
   .data_b (vif.data_b )
   );


initial begin
  uvm_config_db #(virtual switch_if)::set(uvm_root::get(), "*", "switch_vif", vif);

  run_test();
  $finish;
end

endmodule // tb_top
