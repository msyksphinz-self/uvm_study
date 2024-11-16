class inst_gen_env extends uvm_env;
  `uvm_component_utils(inst_gen_env);
  function new (string name="inst_gen_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  inst_gen_agent a0;        // Agent handle

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a0  = inst_gen_agent::type_id::create("a0", this);
  endfunction // build_phase

  virtual function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);
  endfunction // connect_phase

endclass // inst_gen_env
