class inst_gen_driver extends uvm_driver #(inst_gen_seq_item);
  `uvm_component_utils (inst_gen_driver)

  function new (string name = "inst_gen_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  virtual inst_gen_if vif;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if (!uvm_config_db #(virtual inst_gen_if)::get(this, "", "inst_gen_vif", vif)) begin
      `uvm_fatal ("DRV", "Could not get vif");
    end
  endfunction // build_phase

  virtual task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever begin
      inst_gen_seq_item m_item;
      `uvm_info ("DRV", $sformatf("Wait for item from sequencer"), UVM_LOW);
      seq_item_port.get_next_item(m_item);
      drive_item(m_item);
      seq_item_port.item_done();
    end
  endtask // run_phase

  virtual task drive_item (inst_gen_seq_item item);
    // item.opcode = 'h33; // ADD
    // item.funct3 = 'h0;  // ADD
    // item.funct7 = 'h0;  // ADD
    `uvm_info("DRV", $sformatf("Inst : %08x DASM(%08x)",
                               {item.funct7, item.rs2, item.rs1, item.funct3, item.rd, item.opcode},
                               {item.funct7, item.rs2, item.rs1, item.funct3, item.rd, item.opcode}), UVM_LOW);
    @ (posedge vif.clk);
  endtask // drive_item

endclass // inst_gen_driver
