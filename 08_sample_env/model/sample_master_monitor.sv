class sample_master_monitor extends uvm_monitor;
  virtual sample_if vif;
  uvm_analysis_port #(sample_scrbd_item) ap_write;
  uvm_analysis_port #(sample_scrbd_item) ap_read;
  event scrbd_e;  // Define event
  `uvm_component_utils(sample_master_monitor)
  function new (string name, uvm_component parent);
    super.new(name, parent);
    ap_write = new("ap_write", this);
    ap_read  = new("ap_read", this);
  endfunction

  function void build_phase(uvm_phase phase);
  bit   status;
    super.build_phase(phase);
    status = uvm_config_db#(virtual sample_if)::get(this, "", "vif", vif);
    if(status==1'b0)
      uvm_report_fatal("NOVIF", {"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  task run_phase(uvm_phase phase);
    string s_trans_kind;
    uvm_report_info("MONITOR", "Hi");
    fork scrbd_write; join_none  // call scrbd_write job parallely
    forever begin
      @(posedge vif.valid);
      wait(vif.ready === 1'b1);
      -> scrbd_e;    // Execute event
      if (vif.write===1'b1) begin
        uvm_report_info("MON", $sformatf("write addr=%02xh wdata=%02xh", vif.addr, vif.wdata));
      end else if (vif.write===1'b0) begin
        uvm_report_info("MON", $sformatf("read  addr=%02xh rdata=%02xh", vif.addr, vif.rdata));
      end else begin
        uvm_report_info("MON", $sformatf("signal write is unknown..."));
      end
    end // forever begin
  endtask // run_phase

  task scrbd_write;
    sample_scrbd_item item;
    forever begin
      @scrbd_e;  // Jumps here?
      item = new();
      item.addr = vif.addr;
      if (vif.write===1'b1)begin
        item.data = vif.wdata; // write側のanalysis_port
        ap_write.write(item);
      end else if(vif.write === 1'b0) begin
        item.data = vif.rdata;
        ap_read.write(item);   // read側のanalysis_port
      end
    end // forever begin
  endtask // scrbd_write

endclass // sample_master_monitor

// class sample_master_monitor extends uvm_monitor;
//   virtual sample_if vif;
//
//   `uvm_component_utils(sample_master_monitor)
//
//   function new (string name, uvm_component parent);
//     super.new(name, parent);
//   endfunction // new
//
//   function void build_phase(uvm_phase phase);
//     bit status;
//     super.build_phase(phase);
//     status = uvm_config_db#(virtual sample_if)::get(this, "", "vif", vif);
//     if(status==1'b0)
//       uvm_report_fatal("NOVIF", {"virtual interface must be set for: ",get_full_name(),".vif"});
//   endfunction // build_phase
//
//   task run_phase(uvm_phase phase);
//     string s_trans_kind;
//     uvm_report_info("MONITOR", "Hi");
//     forever begin
//       @(posedge vif.valid);
//       wait (vif.ready == 1'b1);
//       if (vif.write===1'b1) begin
//         uvm_report_info ("MON", $sformatf("write addr=%02xh wdata=%02xh", vif.addr, vif.wdata));
//       end else if(vif.write===1'b0) begin
//         uvm_report_info ("MON", $sformatf("read  addr=%02xh rdata=%02xh", vif.addr, vif.rdata));
//       end else begin
//         uvm_report_info ("MON", $sformatf("signal write is unknown ..."));
//       end
//     end // forever begin
//   endtask // run_phase
//
// endclass // sample_monitor

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
