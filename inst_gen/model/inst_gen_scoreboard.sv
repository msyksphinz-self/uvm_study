class inst_gen_scoreboard extends uvm_scoreboard;
  `uvm_component_utils (inst_gen_scoreboard);

  function new (string name = "inst_gen_scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  inst_gen_seq_item ref_item;
  uvm_analysis_imp #(inst_gen_seq_item, inst_gen_scoreboard) m_analysis_imp;

  typedef logic [31:0] mem_array_t [0:255];
  mem_array_t expected_mem;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    m_analysis_imp = new("m_analysis_imp", this);

    for (int i = 0; i < 256; i++) begin
      expected_mem[i] = 'h0;
    end
  endfunction // build_phase

  virtual function write (inst_gen_seq_item item);

    if (item.i_valid) begin
      if (item.i_rw) begin
        // 書き込み操作：期待値メモリを更新
        expected_mem[item.i_addr] = item.i_data;
      end else begin
        // 読み出し操作：データを比較
        if (expected_mem[item.i_addr] !== item.o_data) begin
          `uvm_error("DATA_MISMATCH", $sformatf("Address 0x%0h: Expected 0x%0h, Got 0x%0h", item.i_addr, expected_mem[item.i_addr], item.o_data))
        end else begin
          `uvm_info("DATA_MATCH", $sformatf("Address 0x%0h: Data matches (0x%0h)", item.i_addr, item.o_data), UVM_LOW)
        end
      end
    end

    `uvm_info (get_type_name(), $sformatf("Scoreboard found packet %s", item.convert2str()), UVM_LOW)

  endfunction // write

endclass // inst_gen_scoreboard
