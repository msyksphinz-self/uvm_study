class sample_scrbd_item extends uvm_object;
  bit [7:0] addr, data;

  `uvm_object_utils_begin(sample_scrbd_item)
    `uvm_field_int(addr, UVM_DEFAULT)
    `uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end

  function new (string name="sample_scrbd_item");
    super.new(name);
  endfunction // new

endclass // sample_scrbd_item
