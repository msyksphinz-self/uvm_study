module mem_rw
(
 input logic          i_clk,

 input logic          i_valid,
 input logic [ 7: 0]  i_addr,
 input logic          i_rw, // Read = 0, Write = 1
 input logic [31: 0]  i_data,

 output logic [31: 0] o_data
 );

logic [31: 0]         mem[256];

always_ff @ (posedge i_clk) begin
  if (i_valid & i_rw) begin
    mem[i_addr] <= i_data;
  end
end

always_ff @ (posedge i_clk) begin
  if (i_valid & !i_rw) begin
    o_data <= mem[i_addr];
  end
end

initial begin
  for (int i = 0; i < 256; i++) begin
    mem[i] = 'h0;
  end
end

endmodule // mem_rw
