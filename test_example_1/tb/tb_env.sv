class tb_env extends uvm_env;
  env        model;
  scoreboard scrbd;  // Generic score-board

  `uvm_component_utils(tb_env)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction // new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(int)::set(this, "scrbd", "mode", 2);
    model = env::type_id::create("model", this);
    scrbd = scoreboard #(reg_item)::type_id::create("scrbd", this);
  endfunction // build_phase

  function void connect_phase(uvm_phase phase);
    model.a0.m0.ap_write.connect(scrbd.ap_exp);  // for expected value
  endfunction // connect_phase

endclass // tb_env
