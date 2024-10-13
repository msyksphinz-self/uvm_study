class sample_seq_item extends uvm_sequence_item;
  logic [ 7: 0] addr, data;

  `uvm_object_utils_begin(sample_seq_item)
    `uvm_field_int(addr, UVM_DEFAULT)
    `uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end

  function new (string name = "sample_seq_item_inst");
    super.new(name);
  endfunction // new

endclass // sample_seq_item
