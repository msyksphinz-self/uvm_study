class env extends uvm_env;
  `uvm_component_utils(env);
  function new (string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  agent a0;        // Agent handle
  scoreboard sb0;  // Scoreboard handle

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a0  = agent::type_id::create("a0", this);
    sb0 = scoreboard::type_id::create("sb0", this);
  endfunction // build_phase

  virtual function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);
    a0.m0.mon_analysis_port.connect (sb0.m_analysis_imp);
  endfunction // connect_phase

endclass // env