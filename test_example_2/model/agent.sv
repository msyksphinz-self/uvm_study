class agent extends uvm_agent;
  `uvm_component_utils(agent)
  function new(string name="agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  driver   d0;                       // Driver handle
  monitor  m0;                       // Monitor handle
  uvm_sequencer #(switch_item) s0;   // Sequencer Handle

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    s0 = uvm_sequencer #(switch_item)::type_id::create("s0", this);
    d0 = driver::type_id::create("d0", this);
    m0 = monitor::type_id::create("m0", this);
  endfunction // build_phase

  virtual function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    d0.seq_item_port.connect(s0.seq_item_export);
  endfunction // connect_phase

endclass // agent
