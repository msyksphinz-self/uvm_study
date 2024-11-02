class gen_item_seq extends uvm_sequence;
  `uvm_object_utils(gen_item_seq)

  function new(string name="gen_item_seq");
    super.new(name);
  endfunction // new

  rand int num;   // Config total number of items to be sent

  constraint c1 { num inside {[5:10]}; }

  virtual task body();
    assert(this.randomize()) else `uvm_error("SEQ", "Randomization of num failed");

    for (int i = 0; i < num; i++) begin
      switch_item m_item = switch_item::type_id::create("m_item");
      start_item(m_item);
      m_item.randomize();
      `uvm_info ("SEQ", $sformatf("Generate new item: "), UVM_LOW)
      m_item.print();
      finish_item(m_item);
    end
    `uvm_info ("SEQ", $sformatf("Done generation of %0d items", num), UVM_LOW)
  endtask // body
endclass // gen_item_seq
