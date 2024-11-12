class mem_rw_seq_item extends uvm_sequence_item;

  rand bit         i_valid;
  rand bit         i_rw;
  rand bit [ 7: 0] i_addr;
  rand bit [31: 0] i_data;

  bit [31: 0]      o_data;

  // Use utility macros to implement standard functions
  // like print, copy, clane, etc
  `uvm_object_utils_begin (mem_rw_seq_item)
    `uvm_field_int (i_valid, UVM_DEFAULT)
    `uvm_field_int (i_rw,    UVM_DEFAULT)
    `uvm_field_int (i_addr,  UVM_DEFAULT)
    `uvm_field_int (i_data,  UVM_DEFAULT)
    `uvm_field_int (o_data,  UVM_DEFAULT)
  `uvm_object_utils_end

  function new (string name = "mem_rw_seq_item");
    super.new(name);
  endfunction // new

  virtual function string convert2str();
    return $sformatf ("i_valid=%d, i_rw=%d, i_addr=0x%0h, i_data=0x%0h, o_data=0x%0h",
                      i_valid, i_rw, i_addr, i_data, o_data);
  endfunction // convert2str

endclass // mem_rw_seq_item
