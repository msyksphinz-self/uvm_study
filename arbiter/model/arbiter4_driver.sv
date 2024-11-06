class arbiter4_driver extends uvm_driver #(arbiter4_seq_item);
  `uvm_component_utils (arbiter4_driver)

  function new (string name = "arbiter4_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  virtual arbiter4_if vif;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if (!uvm_config_db #(virtual arbiter4_if)::get(this, "", "arbiter4_vif", vif)) begin
      `uvm_fatal ("DRV", "Could not get vif");
    end
  endfunction // build_phase

  virtual task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever begin
      arbiter4_seq_item m_item;
      `uvm_info ("DRV", $sformatf("Wait for item from sequencer"), UVM_LOW);
      seq_item_port.get_next_item(m_item);
      drive_item(m_item);
      seq_item_port.item_done();
    end
  endtask // run_phase

  virtual task drive_item (arbiter4_seq_item item);
    vif.i_valid0 <= item.i_valid0;
    vif.i_data0  <= item.i_data0;
    vif.i_valid1 <= item.i_valid1;
    vif.i_data1  <= item.i_data1;
    vif.i_valid2 <= item.i_valid2;
    vif.i_data2  <= item.i_data2;
    vif.i_valid3 <= item.i_valid3;
    vif.i_data3  <= item.i_data3;
    @ (posedge vif.clk);
  endtask // drive_item

endclass // arbiter4_driver
