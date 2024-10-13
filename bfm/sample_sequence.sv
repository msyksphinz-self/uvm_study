virtual class sample_base_sequence extends uvm_sequence #(sample_seq_item);
  function new(string name="sample_base_seq");
    super.new(name);
    set_automatic_phase_objection(1);
  endfunction // new
endclass // sample_base_sequnece

class issue_one_trans_seq extends sample_base_sequence;
  `uvm_object_utils(issue_one_trans_seq);

  function new(string name="issue_one_trans_seq");
    super.new(name);
  endfunction // new

  virtual task body();
    sample_seq_item trans_item;
    $display ("I am issue_one_trans_seq");
    `uvm_create(trans_item);
    trans_item.addr = 8'h00;
    trans_item.data = 8'h10;
    `uvm_send(trans_item);
    #1000ns;
  endtask // body

endclass // issue_one_trans_seq
