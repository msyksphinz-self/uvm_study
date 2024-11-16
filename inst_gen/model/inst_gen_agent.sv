class inst_gen_agent extends uvm_agent;
  `uvm_component_utils(inst_gen_agent);
  function new(string name="inst_gen_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  inst_gen_driver  d0;   // Driver handle
  uvm_sequencer #(inst_gen_seq_item) s0;  // Sequencer Handle

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    s0 = uvm_sequencer#(inst_gen_seq_item)::type_id::create("s0", this);
    d0 = inst_gen_driver::type_id::create("d0", this);
  endfunction // build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d0.seq_item_port.connect(s0.seq_item_export);
  endfunction // connect_phase

endclass // inst_gen_agent
