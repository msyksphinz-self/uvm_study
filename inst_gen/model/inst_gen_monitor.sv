class inst_gen_monitor extends uvm_monitor;
  `uvm_component_utils(inst_gen_monitor);

  function new (string name="inst_gen_monitor", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  uvm_analysis_port #(inst_gen_seq_item) mon_analysis_port;
  virtual inst_gen_if vif;

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if (!uvm_config_db #(virtual inst_gen_if)::get(this, "", "inst_gen_vif", vif)) begin
      `uvm_fatal ("MON", "Could not give vif");
      end
    mon_analysis_port = new ("mon_analysis_port", this);
  endfunction // build_phase

  virtual task run_phase (uvm_phase phase);

    logic prev_read_req;
    logic [7:0] prev_read_addr;

    super.run_phase (phase);
    // This task monitors the interface for a complete
    // transactions and writes into analysis port when complete

    forever begin
      inst_gen_seq_item item = new;

      item.i_valid = 1'b0;

      @ (posedge vif.clk);

      if (prev_read_req) begin
        item = inst_gen_seq_item::type_id::create("read_tr", this);
        item.i_valid = 1'b1;
        item.i_addr  = prev_read_addr;
        item.i_rw    = 0; // Read
        item.i_data  = 'x;
        item.o_data  = vif.o_data;
        `uvm_info (get_type_name(), $sformatf("Monitor found packet %s", item.convert2str()), UVM_LOW)
        mon_analysis_port.write(item);
        prev_read_req = 1'b0;
      end

      if (vif.i_valid && vif.i_rw) begin
        item = inst_gen_seq_item::type_id::create("write_tr", this);
        item.i_valid = vif.i_valid;
        item.i_addr  = vif.i_addr;
        item.i_rw    = vif.i_rw;
        item.i_data  = vif.i_data;
        item.o_data = 'x;
        `uvm_info (get_type_name(), $sformatf("Monitor found packet %s", item.convert2str()), UVM_LOW)
        mon_analysis_port.write(item);
      end

      // Check current cycle read request
      if (vif.i_valid && !vif.i_rw) begin
        prev_read_req  = 1'b1;
        prev_read_addr = vif.i_addr;
        `uvm_info (get_type_name(), $sformatf("Read request found. Addr=0x%0x", prev_read_addr), UVM_LOW)
      end

    end // forever begin
  endtask // run_phase

endclass // inst_gen_monitor
