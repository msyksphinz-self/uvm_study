interface inst_gen_if (input logic clk);

  logic          i_valid;
  logic [ 7: 0]  i_addr;
  logic          i_rw;
  logic [31: 0]  i_data;

  logic [31: 0]  o_data;

endinterface // inst_gen_if
