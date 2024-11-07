// `timescale 1ps/1ps

module tb_top;

// UVM class library
`include "uvm_macros.svh"
import uvm_pkg::*;

// uvm user code
`include "arbiter4_model.svh"

`include "test.sv"

/////////////////////////////////////
logic clk;
arbiter4_if vif(clk);
// clk
initial begin
  clk <= 1'b1;
  #100;
  forever #50 clk <= ~clk;
end

arbiterN_rr u0
  (
   .i_clk     (clk),
   .i_reset_n (1'b0 /* Temporary */),

   .i_valid0 (vif.i_valid0),
   .i_data0  (vif.i_data0 ),
   .i_valid1 (vif.i_valid1),
   .i_data1  (vif.i_data1 ),
   .i_valid2 (vif.i_valid2),
   .i_data2  (vif.i_data2 ),
   .i_valid3 (vif.i_valid3),
   .i_data3  (vif.i_data3 ),

   .o_valid  (vif.o_valid ),
   .o_data   (vif.o_data  )
   );


initial begin
  uvm_config_db #(virtual arbiter4_if)::set(uvm_root::get(), "*", "arbiter4_vif", vif);

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
