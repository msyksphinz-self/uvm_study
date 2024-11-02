class scoreboard extends uvm_scoreboard;
  `uvm_component_utils (scoreboard)

  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  uvm_analysis_imp #(switch_item, scoreboard) m_analysis_imp;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_analysis_imp = new("m_analysis_imp", this);
  endfunction // build_phase

  virtual function write(switch_item item);
    if (item.addr inside {[0:'h3f]}) begin
      if (item.addr_a != item.addr | item.data_a != item.data) begin
        `uvm_error("SCBD", $sformatf ("ERROR! Mismatch addr=0x%0h data=0x%0h addr_a=0x%0h data_a=0x%0h",
                                      item.addr, item.data, item.addr_a, item.data_a));
      end else begin
        `uvm_info("SCBD", $sformatf ("PASS! Match addr=0x%0h data=0x%0h addr_a=0x%0h data_a=0x%0h",
                                     item.addr, item.data, item.addr_a, item.data_a), UVM_LOW);
      end
    end else begin
      if (item.addr_b != item.addr | item.data_b != item.data) begin
        `uvm_error("SCBD", $sformatf ("ERROR! Mismatch addr=0x%0h data=0x%0h addr_b=0x%0h data_b=0x%0h",
                                      item.addr, item.data, item.addr_b, item.data_b));
      end else begin
        `uvm_info("SCBD", $sformatf ("PASS! Match addr=0x%0h data=0x%0h addr_a=0x%0h data_a=0x%0h",
                                     item.addr, item.data, item.addr_b, item.data_b), UVM_LOW);
      end
    end // else: !if(item.addr inside {[0:'h3f]})
  endfunction // write

endclass // scoreboard
