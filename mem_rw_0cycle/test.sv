class test extends uvm_test;
  `uvm_component_utils(test);
  function new(string name="test", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  mem_rw_env        e0;
  virtual mem_rw_if vif;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e0 = mem_rw_env::type_id::create("e0", this);
    if (!uvm_config_db #(virtual mem_rw_if)::get(this, "", "mem_rw_vif", vif)) begin
      `uvm_fatal("TEST", "Did not get vif")
    end
    uvm_config_db #(virtual mem_rw_if)::set(this, "e0.a0.*", "mem_rw_vif", vif);
  endfunction // build_phase

  virtual task run_phase (uvm_phase phase);
    mem_rw_gen_item_seq seq = mem_rw_gen_item_seq::type_id::create ("seq");
    phase.raise_objection(this);
    apply_reset();

    seq.randomize();
    seq.start(e0.a0.s0);
    phase.drop_objection(this);
  endtask // run_phase

  virtual task apply_reset();
    // vif.rstn <= 1'b0;
    // repeat(5) @ (posedge vif.clk);
    // vif.rstn <= 1'b1;
    // repeat(10) @ (posedge vif.clk);
  endtask // apply_reset

endclass // test
