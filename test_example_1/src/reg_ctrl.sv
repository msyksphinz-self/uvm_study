module reg_ctrl
  #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 16,
    parameter DEPTH = 256,
    parameter RESET_VAL = 16'h1234
    )
(
 input logic                    clk,
 input logic                    rstn,
 input logic [ADDR_WIDTH-1: 0]  addr,
 input logic                    sel,
 input logic                    wr,
 input logic [DATA_WIDTH-1: 0]  wdata,
 output logic [DATA_WIDTH-1: 0] rdata,
 output logic                   ready
 );

logic [DATA_WIDTH-1: 0]         ctrl[DEPTH];

logic                           ready_dly;
logic                           ready_pe;


always_ff @ (posedge clk) begin
  if (!rstn) begin
    for (int i = 0; i < DEPTH; i++) begin
      ctrl[i] <= RESET_VAL;
    end
  end else begin
    if (sel & ready & wr) begin
      ctrl[addr] <= wdata;
    end

    if (sel & ready & !wr) begin
      rdata <= ctrl[addr];
    end else begin
      rdata <= 'h0;
    end
  end // else: !if(!rstn)
end // always_ff @ (posedge clk)

always_ff @ (posedge clk) begin
  if (!rstn) begin
    ready <= 1'b1;
  end else begin
    if (sel & ready_pe) begin
      ready <= 1'b1;
    end
    if (sel & ready & !wr) begin
      ready <= 1'b0;
    end
  end
end // always_ff @ (posedge clk)

always_ff @ (posedge clk) begin
  if (!rstn) begin
    ready_dly <= 1'b1;
  end else begin
    ready_dly <= ready;
  end
end

assign ready_pe = ~ready & ready_dly;

endmodule // reg_ctrl
