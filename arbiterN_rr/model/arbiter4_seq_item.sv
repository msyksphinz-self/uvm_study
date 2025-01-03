class arbiter4_seq_item extends uvm_sequence_item;

  rand bit         i_valid0;
  rand bit [15: 0] i_data0;
  rand bit         i_valid1;
  rand bit [15: 0] i_data1;
  rand bit         i_valid2;
  rand bit [15: 0] i_data2;
  rand bit         i_valid3;
  rand bit [15: 0] i_data3;

  bit              o_valid;
  bit [15: 0]      o_data;

  // Use utility macros to implement standard functions
  // like print, copy, clane, etc
  `uvm_object_utils_begin (arbiter4_seq_item)
    `uvm_field_int (i_valid0, UVM_DEFAULT)
    `uvm_field_int (i_data0,  UVM_DEFAULT)
    `uvm_field_int (i_valid1, UVM_DEFAULT)
    `uvm_field_int (i_data1,  UVM_DEFAULT)
    `uvm_field_int (i_valid2, UVM_DEFAULT)
    `uvm_field_int (i_data2,  UVM_DEFAULT)
    `uvm_field_int (i_valid3, UVM_DEFAULT)
    `uvm_field_int (i_data3,  UVM_DEFAULT)
    `uvm_field_int (o_valid, UVM_DEFAULT)
    `uvm_field_int (o_data,  UVM_DEFAULT)
  `uvm_object_utils_end

  function new (string name = "arbiter4_seq_item");
    super.new(name);
  endfunction // new

  virtual function string convert2str();
    return $sformatf ("i_valid0=%d, i_data0=0x%0h, i_valid1=%d, i_data1=0x%0h, i_valid2=%d, i_data2=0x%0h, i_valid3=%d, i_data3=0x%0h, o_valid=%d, o_data=0x%0h",
                      i_valid0, i_data0, i_valid1, i_data1, i_valid2, i_data2, i_valid3, i_data3, o_valid, o_data);
  endfunction // convert2str

endclass // arbiter4_seq_item
