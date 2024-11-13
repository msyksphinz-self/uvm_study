class mem_rw_driver extends uvm_driver #(mem_rw_seq_item);
  `uvm_component_utils (mem_rw_driver)

  function new (string name = "mem_rw_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  virtual mem_rw_if vif;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if (!uvm_config_db #(virtual mem_rw_if)::get(this, "", "mem_rw_vif", vif)) begin
      `uvm_fatal ("DRV", "Could not get vif");
    end
  endfunction // build_phase

  virtual task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever begin
      mem_rw_seq_item m_item;
      `uvm_info ("DRV", $sformatf("Wait for item from sequencer"), UVM_LOW);
      seq_item_port.get_next_item(m_item);
      drive_item(m_item);
      seq_item_port.item_done();
    end
  endtask // run_phase

  virtual task drive_item (mem_rw_seq_item item);
    vif.i_valid <= item.i_valid;
    vif.i_rw    <= item.i_rw;
    vif.i_addr  <= item.i_addr;
    vif.i_data  <= item.i_data;
    @ (posedge vif.clk);
  endtask // drive_item

endclass // mem_rw_driver
