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
reg_if vif(clk);
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

reg_ctrl u0
  (
   .clk   (clk ),
   .rstn  (vif.rstn ),
   .addr  (vif.addr ),
   .sel   (vif.sel  ),
   .wr    (vif.wr   ),
   .wdata (vif.wdata),
   .rdata (vif.rdata),
   .ready (vif.ready)
   );


initial begin
  // uvm_config_db_options::turn_on_tracing();

  uvm_config_db #(virtual reg_if)::set(uvm_root::get(), "*", "reg_vif", vif);

  run_test();
  $finish;
end

endmodule // tb_top
