class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  function new (string name = "scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  reg_item refq[`DEPTH];
  uvm_analysis_imp #(reg_item, scoreboard) m_analysis_imp;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    m_analysis_imp = new("m_analysis_imp", this);
  endfunction // build_phase

  virtual function write (reg_item item);
    if (item.wr) begin
      if (refq[item.addr] == null) begin
        refq[item.addr] = new;
      end
      refq[item.addr] = item;
      `uvm_info (get_type_name(), $sformatf("Store addr=0x%0h wr=0x%0h data=0x%0h", item.addr, item.wr, item.wdata), UVM_LOW)
    end

    if (!item.wr) begin
      if (refq[item.addr] == null) begin
        if (item.rdata != 'h1234) begin
          `uvm_error(get_type_name(),
                     $sformatf("First time read, addr=0x%0h exp=1234 act=0x%0h",
                               item.addr, item.rdata))
        end else begin
          `uvm_info(get_type_name(),
                    $sformatf("PASS! First time read, addr=0x%0h exp=1234 act=0x%0h",
                              item.addr, item.rdata), UVM_LOW)
        end
      end else begin // if (refq[item.addr] == null)
        if (item.rdata != refq[item.addr].wdata) begin
          `uvm_error(get_type_name(),
                     $sformatf("addr=0x%0h exp=0x%0h act=0x%0h",
                               item.addr, refq[item.addr].wdata, item.rdata))
        end else begin
          `uvm_info(get_type_name(),
                    $sformatf("PASS! First time read, addr=0x%0h exp=0x%0h act=0x%0h",
                              item.addr, refq[item.addr].wdata, item.rdata), UVM_LOW)
        end
      end // else: !if(refq[item.addr] == null)
    end // if (!item.wr)
  endfunction // write
endclass // scoreboard
