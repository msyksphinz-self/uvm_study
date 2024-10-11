class sample_seq_item extends uvm_sequence_item;
  logic [ 7: 0] addr, wdata, rdata;
  bit  write;
  bit [ 3: 0] wait_cycle;
  `uvm_object_utils(sample_seq_item)

  function new (string name="sample_seq_item_inst");
    super.new(name);
  endfunction

endclass // sample_seq_item
