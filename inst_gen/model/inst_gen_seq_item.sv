class inst_gen_seq_item extends uvm_sequence_item;

  rand bit [ 6: 0] opcode;
  rand bit [ 4: 0] rd;
  rand bit [ 2: 0] funct3;
  rand bit [ 4: 0] rs1;
  rand bit [ 4: 0] rs2;
  rand bit [ 6: 0] funct7;

  // constraint inst_opcode_c { soft opcode inside {'h33}; }
  // constraint inst_funct3_c { soft funct3 inside {'h0}; }
  // constraint inst_funct7_c { soft funct7 inside {'h0}; }

  // Use utility macros to implement standard functions
  // like print, copy, clane, etc
  `uvm_object_utils_begin (inst_gen_seq_item)
    `uvm_field_int (opcode, UVM_DEFAULT)
    `uvm_field_int (rd,     UVM_DEFAULT)
    `uvm_field_int (funct3, UVM_DEFAULT)
    `uvm_field_int (rs1,    UVM_DEFAULT)
    `uvm_field_int (rs2,    UVM_DEFAULT)
    `uvm_field_int (funct7, UVM_DEFAULT)
  `uvm_object_utils_end

  function new (string name = "inst_gen_seq_item");
    super.new(name);
  endfunction // new

endclass // inst_gen_seq_item
