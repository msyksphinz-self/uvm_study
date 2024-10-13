class sample_monitor extends uvm_monitor;
  `uvm_component_utils(sample_monitor);

  virtual sample_if vif;

  function new (string name="sample_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction // new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual sample_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
    end
  endfunction // build_phase

  task run_phase (uvm_phase phase);
    fork
      // check_clock;
      check_trans;
    join
  endtask // run_phase

  task check_trans;
    forever begin
      @(posedge vif.valid) uvm_report_info("MON", $sformatf("addr=%02xh, data=%02xh", vif.addr, vif.data));
    end
  endtask // check_trans

  task check_clock;
    forever begin
      wait (vif.clk === 1'b0);
      uvm_report_info ("MON", "fall clock");
      wait (vif.clk === 1'b1);
      uvm_report_info ("MON", "rise clock");
    end
  endtask // check_clock

endclass // sample_monitor
