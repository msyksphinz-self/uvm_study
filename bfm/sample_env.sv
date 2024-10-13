class sample_env extends uvm_env;
  `uvm_component_utils (sample_env);

  sample_agent agent;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction // new

  function void build_phase(uvm_phase phase);
    super.build_phase (phase);
    agent = sample_agent::type_id::create ("agent", this);
  endfunction // build_phase

endclass // sample_env
