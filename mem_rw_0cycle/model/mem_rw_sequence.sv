class mem_rw_gen_item_seq extends uvm_sequence;
  `uvm_object_utils (mem_rw_gen_item_seq);

  function new (string name = "mem_rw_gen_item_seq");
    super.new(name);
  endfunction // new

  rand int num;

  constraint c1 { soft num inside {[1000:2000]}; }

  virtual task body ();
    assert(this.randomize()) else `uvm_error("SEQ", "Randomization of num failed");

    for (int i = 0; i < num; i++) begin
      mem_rw_seq_item item = mem_rw_seq_item::type_id::create("item");
      if (!item.randomize()) begin
        `uvm_error("mem_rw_seq", "Randomization failed!")
      end
      start_item(item);
      `uvm_info ("SEQ", $sformatf ("Generate new item: "), UVM_LOW)
      item.print();
      finish_item(item);
    end
    `uvm_info ("SEQ", $sformatf ("Done generation of %0d items", num), UVM_LOW)
  endtask // body

endclass // mem_rw_gen_item_seq
