module switch
  #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 16,
    parameter ADDR_DIV   = 8'h3f
    )
(
 input logic clk,
 input logic rstn,
 input logic vld,

 input logic [ADDR_WIDTH-1: 0] addr,
 input logic [DATA_WIDTH-1: 0] data,

 output logic [ADDR_WIDTH-1: 0] addr_a,
 output logic [DATA_WIDTH-1: 0] data_a,

 output logic [ADDR_WIDTH-1: 0] addr_b,
 output logic [DATA_WIDTH-1: 0] data_b
 );


always_ff @ (posedge clk) begin
  if (!rstn) begin
    addr_a <= 'h0;
    data_a <= 'h0;
    addr_b <= 'h0;
    data_b <= 'h0;
  end else begin
    if (vld) begin
      if (addr >= 'h0 && addr <= ADDR_DIV) begin
        addr_a <= addr;
        data_a <= data;
        addr_b <= 'h0;
        data_b <= 'h0;
      end else begin
        addr_a <= 'h0;
        data_a <= 'h0;
        addr_b <= addr;
        data_b <= data;
      end // else: !if(addr >= 'h0 && addr <= ADDR_DIV)
    end // if (vld)
  end // else: !if(!rstn)
end // always_ff @ (posedge clk)

endmodule // switch
