class arbiter2_rr_monitor extends uvm_monitor;
  `uvm_component_utils(arbiter2_rr_monitor);

  function new (string name="arbiter2_rr_monitor", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  uvm_analysis_port #(arbiter2_rr_seq_item) mon_analysis_port;
  virtual arbiter2_rr_if vif;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if (!uvm_config_db #(virtual arbiter2_rr_if)::get(this, "", "arbiter2_rr_vif", vif)) begin
      `uvm_fatal ("MON", "Could not give vif");
      end
    mon_analysis_port = new ("mon_analysis_port", this);
  endfunction // build_phase

  virtual task run_phase (uvm_phase phase);
    super.run_phase (phase);
    // This task monitors the interface for a complete
    // transactions and writes into analysis port when complete
    forever begin
      arbiter2_rr_seq_item item = new;

      @ (posedge vif.clk);
      if (vif.i_valid0 | vif.i_valid1) begin
        item.i_valid0 = vif.i_valid0;
        item.i_data0  = vif.i_data0;
        item.i_valid1 = vif.i_valid1;
        item.i_data1  = vif.i_data1;

        item.o_valid = vif.o_valid;
        item.o_data  = vif.o_data;

        `uvm_info (get_type_name(), $sformatf("Monitor found packet %s", item.convert2str()), UVM_LOW)
        mon_analysis_port.write(item);
      end // if (vif.i_valid0 | vif.i_valid1 | vif.i_valid2 | vif.i_valid3)
    end // forever begin
  endtask // run_phase

endclass // arbiter2_rr_monitor
