class sample_agent extends uvm_agent;
  `uvm_component_utils(sample_agent);

  sample_driver    driver;
  sample_sequencer sequencer;
  sample_monitor   monitor;

  // `uvm_new_func
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction // new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    driver    = sample_driver::type_id::create("driver",    this);
    monitor   = sample_monitor::type_id::create("monitor",   this);
    sequencer = sample_sequencer::type_id::create("sequencer", this);
  endfunction // build_phase

  function void connect_phase (uvm_phase phase);
    driver.seq_item_port.connect (sequencer.seq_item_export);
  endfunction // connect_phase

endclass // sample_agent
