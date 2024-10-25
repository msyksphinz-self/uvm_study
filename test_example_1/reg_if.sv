interface reg_if(input logic clk);

  logic valid, ready;

  logic rstn;

  logic                    sel;
  logic [`ADDR_WIDTH-1: 0] addr;
  logic [`DATA_WIDTH-1: 0] wdata;
  logic                    wr;
  logic [`DATA_WIDTH-1: 0] rdata;

endinterface // reg_if
