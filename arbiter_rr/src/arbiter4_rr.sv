module arbiter4_rr
  (
   input logic          i_clk,
   input logic          i_reset_n,

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

logic [ 1: 0]           r_current_ptr;
logic [ 1: 0]           w_current_ptr_next;
logic [ 1: 0]           w_idx[4];
logic [15: 0]           w_data[4];
logic [ 3: 0]           w_valids;

always_comb begin
  case (r_current_ptr)
    'h0 : begin
      w_valids = {i_valid1, i_valid2, i_valid3, i_valid0};
      w_idx    = {1, 2, 3, 0};
      w_data[3] = i_data1;
      w_data[2] = i_data2;
      w_data[1] = i_data3;
      w_data[0] = i_data0;
    end
    'h1 : begin
      w_valids = {i_valid2, i_valid3, i_valid0, i_valid1};
      w_idx    = {2, 3, 0, 1};
      w_data[3] = i_data2;
      w_data[2] = i_data3;
      w_data[1] = i_data0;
      w_data[0] = i_data1;
    end
    'h2 : begin
      w_valids = {i_valid3, i_valid0, i_valid1, i_valid2};
      w_idx    = {3, 0, 1, 2};
      w_data[3] = i_data3;
      w_data[2] = i_data0;
      w_data[1] = i_data1;
      w_data[0] = i_data2;
    end
    default begin // 'h3 : begin
      w_valids = {i_valid0, i_valid1, i_valid2, i_valid3};
      w_idx    = {0, 1, 2, 3};
      w_data[3] = i_data0;
      w_data[2] = i_data1;
      w_data[1] = i_data2;
      w_data[0] = i_data3;
    end
  endcase // case (r_current_ptr)

  o_valid = i_valid0 | i_valid1 | i_valid2 | i_valid3;

  casex (w_valids)
    4'b1xxx : begin o_data = w_data[3]; w_current_ptr_next = w_idx[3]; end
    4'b01xx : begin o_data = w_data[2]; w_current_ptr_next = w_idx[2]; end
    4'b001x : begin o_data = w_data[1]; w_current_ptr_next = w_idx[1]; end
    4'b0001 : begin o_data = w_data[0]; w_current_ptr_next = w_idx[0]; end
    default : begin o_data = 'h0;       w_current_ptr_next = 'h0;      end
  endcase // casex ({i_valid3, i_valid2, i_valid1, i_valid0})

end // always_comb

always_ff @ (posedge i_clk, negedge i_reset_n) begin
  if (!i_reset_n) begin
    r_current_ptr <= 'b1000;
  end else begin
    r_current_ptr <= w_current_ptr_next;
  end
end



endmodule // arbiter4
