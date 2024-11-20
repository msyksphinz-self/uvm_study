class arbiter2_rr_scoreboard extends uvm_scoreboard;
  `uvm_component_utils (arbiter2_rr_scoreboard);

  function new (string name = "arbiter2_rr_scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  arbiter2_rr_seq_item ref_item;
  logic                curr_pointer;
  uvm_analysis_imp #(arbiter2_rr_seq_item, arbiter2_rr_scoreboard) m_analysis_imp;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    m_analysis_imp = new("m_analysis_imp", this);

    curr_pointer = 0;
  endfunction // build_phase

  virtual function write (arbiter2_rr_seq_item item);

    `uvm_info (get_type_name(), $sformatf("pointer=%d, Scoreboard found packet %s", curr_pointer, item.convert2str()), UVM_LOW)

    if ((item.i_valid1 | item.i_valid0) &&
        !item.o_valid) begin
        `uvm_error (get_type_name(),
                    $sformatf ("valid3-0 activated, but output not activated"));
    end

    case (curr_pointer)
      'h0 : begin
        if (item.i_valid0) begin
          curr_pointer = 1;
          if (item.o_data != item.i_data0) begin
            `uvm_error (get_type_name(),
                        $sformatf ("valid0 activated, but data different. o_data=0x%04h data0=0x%h",
                                   item.o_data, item.i_data0));
          end
        end else if (item.i_valid1) begin
          curr_pointer = 0;
          if (item.o_data != item.i_data1) begin
            `uvm_error (get_type_name(),
                        $sformatf ("valid1 activated, but data different. o_data=0x%04h data1=0x%h",
                                   item.o_data, item.i_data1));
          end
        end
      end // case: 'h0
      'h1 : begin
        if (item.i_valid1) begin
          curr_pointer = 0;
          if (item.o_data != item.i_data1) begin
            `uvm_error (get_type_name(),
                        $sformatf ("valid1 activated, but data different. o_data=0x%04h data1=0x%h",
                                   item.o_data, item.i_data1));
          end
        end else if (item.i_valid0) begin
          curr_pointer = 1;
          if (item.o_data != item.i_data0) begin
            `uvm_error (get_type_name(),
                        $sformatf ("valid0 activated, but data different. o_data=0x%04h data0=0x%h",
                                   item.o_data, item.i_data0));
          end
        end
      end // case: 'h1
    endcase // case (curr_pointer)
  endfunction // write

endclass // arbiter2_rr_scoreboard
