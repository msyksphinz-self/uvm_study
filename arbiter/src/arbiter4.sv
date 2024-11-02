module arbiter4
  (
   input logic          i_valid0,
   input logic [15: 0]  i_data0,
   input logic          i_valid1,
   input logic [15: 0]  i_data1,
   input logic          i_valid2,
   input logic [15: 0]  i_data2,
   input logic          i_valid3,
   input logic [15: 0]  i_data3,

   output logic         o_valid,
   output logic [15: 0] o_data
   );

always_comb begin
  o_valid = i_valid0 | i_valid1 | i_valid2 | i_valid3;

  casex ({i_valid3, i_valid2, i_valid1, i_valid0})
    4'b1xxx : o_data = i_data3;
    4'b01xx : o_data = i_data2;
    4'b001x : o_data = i_data1;
    4'b0001 : o_data = i_data0;
    default : o_data = 'h0;
  endcase // casex ({i_valid3, i_valid2, i_valid1, i_valid0})

end // always_comb


endmodule // arbiter4
