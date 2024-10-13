class tb_env extends uvm_env;
  // インスタンス名はenvでもいいが、もし複数のモデルを組み込むならば、個々に判別できる
  // 名前でなければならないため、このようなインスタンス名にしている
  sample_env    sample_model;
  gp_scoreboard #(sample_scrbd_item, bit[ 7: 0]) sample_scrbd;  // Generic score-board

  `uvm_component_utils(tb_env)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction // new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(int)::set(this, "sample_scrbd", "mode", 2);
    sample_model = sample_env::type_id::create("sample_model", this);
    sample_scrbd = gp_scoreboard#(sample_scrbd_item)::type_id::create("sample_scrbd", this);
  endfunction // build_phase

  function void connect_phase(uvm_phase phase);
    sample_model.master.monitor.ap_write.connect(sample_scrbd.ap_exp);  // for expected value
    sample_model.master.monitor.ap_read.connect (sample_scrbd.ap_obs);  // for monitoring value
  endfunction // connect_phase

endclass // tb_env
