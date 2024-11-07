interface arbiter4_if (input logic clk);

  logic          i_valid0;
  logic [15: 0]  i_data0;
  logic          i_valid1;
  logic [15: 0]  i_data1;
  logic          i_valid2;
  logic [15: 0]  i_data2;
  logic          i_valid3;
  logic [15: 0]  i_data3;

  logic          o_valid;
  logic [15: 0]  o_data;

endinterface // arbiter4_if
