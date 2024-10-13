`timescale 1ps/1ps

module tb_top;

// UVM ////////////////////////////////////////////////
`include "uvm_macros.svh"
import uvm_pkg::*;

// model
`include "sample.svh"
`include "sample_test.sv"

//////////////////////////////////////////////////////
logic rstz, clk;
//
// rstz   _________|^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// clk    ^^^^^^^^^^^^^^|__|^^|__|^^|__|^^|__|^^|__|^^
//
sample_if sif(clk, rstz);  // interface

initial begin
  fork begin
    clk = 1'b1;
    #100ns;
    forever #50ns clk = ~clk;
  end begin
    rstz = 1'b0;
    #100ns;
    rstz = 1'b1;
  end
  join
end // initial begin

initial begin
  uvm_config_db#(virtual sample_if)::set(uvm_root::get(), "*.env.*", "vif", sif);
  run_test();
end

endmodule // tb_top
