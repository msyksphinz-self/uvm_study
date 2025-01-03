// `timescale 1ps/1ps

module tb_top;

// UVM class library
`include "uvm_macros.svh"
import uvm_pkg::*;

// uvm user code
`include "arbiter2_rr_model.svh"

`include "test.sv"

/////////////////////////////////////
logic clk;
logic reset_n;
arbiter2_rr_if vif(clk);
// clk
initial begin
  clk <= 1'b1;
  reset_n <= 1'b0;
  #100;
  reset_n <= 1'b1;
  forever #50 clk <= ~clk;
end

arbiter2_rr u0
  (
   .i_clk     (clk),
   .i_reset_n (reset_n),

   .i_valid0 (vif.i_valid0),
   .i_data0  (vif.i_data0 ),
   .i_valid1 (vif.i_valid1),
   .i_data1  (vif.i_data1 ),

   .o_valid  (vif.o_valid ),
   .o_data   (vif.o_data  )
   );


initial begin
  uvm_config_db #(virtual arbiter2_rr_if)::set(uvm_root::get(), "*", "arbiter2_rr_vif", vif);

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
