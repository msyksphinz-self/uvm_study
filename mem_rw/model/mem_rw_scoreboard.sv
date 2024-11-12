class mem_rw_scoreboard extends uvm_scoreboard;
  `uvm_component_utils (mem_rw_scoreboard);

  function new (string name = "mem_rw_scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  mem_rw_seq_item ref_item;
  uvm_analysis_imp #(mem_rw_seq_item, mem_rw_scoreboard) m_analysis_imp;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    m_analysis_imp = new("m_analysis_imp", this);
  endfunction // build_phase

  virtual function write (mem_rw_seq_item item);

    `uvm_info (get_type_name(), $sformatf("Scoreboard found packet %s", item.convert2str()), UVM_LOW)

  endfunction // write

endclass // mem_rw_scoreboard
