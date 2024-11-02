class arbiter4_scoreboard extends uvm_scoreboard;
  `uvm_component_utils (arbiter4_scoreboard);

  function new (string name = "arbiter4_scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  arbiter4_seq_item ref_item;
  uvm_analysis_imp #(arbiter4_seq_item, arbiter4_scoreboard) m_analysis_imp;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    m_analysis_imp = new("m_analysis_imp", this);
  endfunction // build_phase

  virtual function write (arbiter4_seq_item item);
    if ((item.i_valid3 | item.i_valid2 | item.i_valid1 | item.i_valid0) &&
        !item.o_valid) begin
        `uvm_error (get_type_name(),
                    $sformatf ("valid3-0 activated, but output not activated"));
    end

    if (item.i_valid3) begin
      if (item.o_data != item.i_data3) begin
        `uvm_error (get_type_name(),
                    $sformatf ("valid3 activated, but data different. o_data=0x%0h data3=0x%h",
                               item.o_data, item.i_data3));
      end
    end else if (item.i_valid2) begin
      if (item.o_data != item.i_data2) begin
        `uvm_error (get_type_name(),
                    $sformatf ("valid2 activated, but data different. o_data=0x%0h data2=0x%h",
                               item.o_data, item.i_data2));
      end
    end else if (item.i_valid1) begin
      if (item.o_data != item.i_data1) begin
        `uvm_error (get_type_name(),
                    $sformatf ("valid1 activated, but data different. o_data=0x%0h data1=0x%h",
                               item.o_data, item.i_data1));
      end
    end else if (item.i_valid0) begin
      if (item.o_data != item.i_data0) begin
        `uvm_error (get_type_name(),
                    $sformatf ("valid0 activated, but data different. o_data=0x%0h data0=0x%h",
                               item.o_data, item.i_data0));
      end
    end
  endfunction // write

endclass // arbiter4_scoreboard
