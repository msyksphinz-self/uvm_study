class arbiter2_rr_agent extends uvm_agent;
  `uvm_component_utils(arbiter2_rr_agent);
  function new(string name="arbiter2_rr_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  arbiter2_rr_driver  d0;   // Driver handle
  arbiter2_rr_monitor m0;   // Monitor handle
  uvm_sequencer #(arbiter2_rr_seq_item) s0;  // Sequencer Handle

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    s0 = uvm_sequencer#(arbiter2_rr_seq_item)::type_id::create("s0", this);
    d0 = arbiter2_rr_driver::type_id::create("d0", this);
    m0 = arbiter2_rr_monitor::type_id::create("m0", this);
  endfunction // build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d0.seq_item_port.connect(s0.seq_item_export);
  endfunction // connect_phase

endclass // arbiter2_rr_agent
