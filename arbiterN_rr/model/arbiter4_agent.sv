class arbiter4_agent extends uvm_agent;
  `uvm_component_utils(arbiter4_agent);
  function new(string name="arbiter4_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  arbiter4_driver  d0;   // Driver handle
  arbiter4_monitor m0;   // Monitor handle
  uvm_sequencer #(arbiter4_seq_item) s0;  // Sequencer Handle

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    s0 = uvm_sequencer#(arbiter4_seq_item)::type_id::create("s0", this);
    d0 = arbiter4_driver::type_id::create("d0", this);
    m0 = arbiter4_monitor::type_id::create("m0", this);
  endfunction // build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d0.seq_item_port.connect(s0.seq_item_export);
  endfunction // connect_phase

endclass // arbiter4_agent
