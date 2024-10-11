class sample_master_monitor extends uvm_monitor;
  virtual sample_if vif;

  `uvm_component_utils(sample_master_monitor)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction // new

  function void build_phase(uvm_phase phase);
    bit status;
    super.build_phase(phase);
    status = uvm_config_db#(virtual sample_if)::get(this, "", "vif", vif);
    if(status==1'b0)
      uvm_report_fatal("NOVIF", {"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction // build_phase

  task run_phase(uvm_phase phase);
    string s_trans_kind;
    uvm_report_info("MONITOR", "Hi");
    forever begin
      @(posedge vif.valid);
      wait (vif.ready == 1'b1);
      if (vif.write===1'b1) begin
        uvm_report_info ("MON", $sformatf("write addr=%02xh wdata=%02xh", vif.addr, vif.wdata));
      end else if(vif.write===1'b0) begin
        uvm_report_info ("MON", $sformatf("read  addr=%02xh rdata=%02xh", vif.addr, vif.rdata));
      end else begin
        uvm_report_info ("MON", $sformatf("signal write is unknown ..."));
      end
    end // forever begin
  endtask // run_phase

endclass // sample_monitor

// class sample_monitor extends uvm_monitor;
//   `uvm_component_utils(sample_monitor)
//
//   function new (string name, uvm_component parent);
//     super.new(name, parent);
//   endfunction
//
//   task run_phase(uvm_phase phase);
//     uvm_report_info("MONITOR", "Hi");
//   endtask
//
// endclass // sample_monitor
