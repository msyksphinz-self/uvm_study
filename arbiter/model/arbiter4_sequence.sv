class arbiter4_gen_item_seq extends uvm_sequence;
  `uvm_object_utils (arbiter4_gen_item_seq);

  function new (string name = "arbiter4_gen_item_seq");
    super.new(name);
  endfunction // new

  rand int num;

  constraint c1 { soft num inside {[10:20]}; }

  virtual task body ();
    for (int i = 0; i < num; i++) begin
      arbiter4_seq_item item = arbiter4_seq_item::type_id::create("item");
      start_item(item);
      `uvm_info ("SEQ", $sformatf ("Generate new item: "), UVM_LOW)
      item.print();
      finish_item(item);
    end
    `uvm_info ("SEQ", $sformatf ("Done generation of %0d items", num), UVM_LOW)
  endtask // body

endclass // arbiter4_gen_item_seq
