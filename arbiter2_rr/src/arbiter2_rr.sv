module arbiter2_rr
  (
   input logic          i_clk,
   input logic          i_reset_n,

   input logic          i_valid0,
   input logic [15: 0]  i_data0,
   input logic          i_valid1,
   input logic [15: 0]  i_data1,

   output logic         o_valid,
   output logic [15: 0] o_data
   );

logic [ 0: 0]           r_curr_ptr;
logic [ 0: 0]           w_curr_ptr_next;

always_comb begin
  w_curr_ptr_next = r_curr_ptr;

  case (r_curr_ptr)
    'h0 : begin
      if (i_valid0) begin
        w_curr_ptr_next = 1;
        o_data = i_data0;
      end else begin
        o_data = i_data1;
      end
    end
    default : begin // 'h1 : begin
      if (i_valid1) begin
        w_curr_ptr_next = 0;
        o_data = i_data1;
      end else begin
        o_data = i_data0;
      end
    end
  endcase // case (r_curr_ptr)

  o_valid = i_valid0 | i_valid1;

end // always_comb

always_ff @ (posedge i_clk, negedge i_reset_n) begin
  if (!i_reset_n) begin
    r_curr_ptr <= 0;
  end else begin
    r_curr_ptr <= w_curr_ptr_next;
  end
end

endmodule // arbiter4
