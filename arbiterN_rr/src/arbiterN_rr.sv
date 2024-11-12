module arbiterN_rr
  #(parameter N = 4)
(
 input logic          i_clk,
 input logic          i_reset_n,

 input logic [N-1: 0] i_valid,
 input logic [15: 0]  i_data[N],

 output logic         o_valid,
 output logic [15: 0] o_data
   );

logic [$clog2(N)-1: 0] r_current_ptr;
logic [$clog2(N)-1: 0] w_current_ptr_next;
logic [$clog2(N)-1: 0] w_idx[N];
logic [15: 0]          w_data[N];
logic [N-1: 0]         w_valids;

always_comb begin
  for (int i = 0; i < N; i++) begin
    logic [$clog2(N)-1: 0] idx;
    idx = r_current_ptr + i + 1 < N ? r_current_ptr + i + 1 : r_current_ptr + i + 1 - N;
    w_valids[i] = i_valid[idx];
    w_idx   [i] = idx;
    w_data  [i] = i_data[idx];
  end

  o_valid = |i_valid;
  o_data = 'h0;
  w_current_ptr_next = r_current_ptr;

  for (int i = N-1; i >= 0; i--) begin
    if (w_valids[i]) begin
      o_data = w_data[i];
      w_current_ptr_next = w_idx[i];
    end
  end

end // always_comb

always_ff @ (posedge i_clk, negedge i_reset_n) begin
  if (!i_reset_n) begin
    r_current_ptr <= 'b1000;
  end else begin
    r_current_ptr <= w_current_ptr_next;
  end
end

endmodule // arbiterN_rr
