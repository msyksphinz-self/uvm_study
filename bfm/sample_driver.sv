class sample_driver extends uvm_driver #(sample_seq_item);
  virtual sample_if vif;

  `uvm_component_utils (sample_driver)
  function new (string name="sample_driver", uvm_component parent);
    super.new(name, parent);
  endfunction // new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual sample_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction // build_phase

  task run_phase (uvm_phase phase);
    sample_seq_item trans_item;
    if (vif == null) begin
      $error("ERROR: vif is null in %s", get_full_name());
    end

    // while reset
    vif.valid <= 1'b0;

    @(posedge vif.rstz);
    forever begin
      seq_item_port.get_next_item (trans_item);
      @(posedge vif.clk);
      vif.valid <= 1'b1;
      vif.addr  <= trans_item.addr;
      vif.data  <= trans_item.data;
      @(posedge vif.clk);
      vif.valid <= 1'b0;
      seq_item_port.item_done();
    end
  endtask // run_phase

endclass // sample_driver
