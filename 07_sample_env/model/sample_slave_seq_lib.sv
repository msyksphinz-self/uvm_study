virtual class sample_slave_base_seq extends uvm_sequence #(sample_seq_item);
  function new(string name="sample_slave_base_seq");
    super.new(name);
    do_not_randomize = 1;
    // set_automatic_phase_objection(1);
  endfunction // new

  // virtual task pre_body();
  //   if (starting_phase!=null) begin
  //      `uvm_info(get_type_name(),
  //                $sformatf("%s pre_body() raising %s objection",
  //                          get_sequence_path(),
  //                          starting_phase.get_name()), UVM_MEDIUM);
  //      starting_phase.raise_objection(this);
  //   end
  // endtask // pre_body
  //
  // // Drop the objection in the post_body so the objection is removed when
  // // the root sequence is complete.
  // virtual task post_body();
  //   if (starting_phase!=null) begin
  //      `uvm_info(get_type_name(),
  //                $sformatf("%s post_body() dropping %s objection",
  //                          get_sequence_path(),
  //                          starting_phase.get_name()), UVM_MEDIUM);
  //     starting_phase.drop_objection(this);
  //   end
  // endtask
endclass

//------------------------------------------------------------------------
class normal_response_seq extends sample_slave_base_seq;
  `uvm_object_utils(normal_response_seq)

  function new (string name="normal_response_seq");
    super.new(name);
  endfunction // new

  virtual task body();
    forever begin
      `uvm_create (req);
      req.wait_cycle <= 1;
      `uvm_send(req)
    end
  endtask // body

endclass // normal_response_seq


class random_response_seq extends sample_slave_base_seq;
  `uvm_object_utils(random_response_seq)

  function new (string name="random_response_seq");
    super.new(name);
  endfunction // new

  virtual task body();
    forever begin
      `uvm_create (req);
      req.wait_cycle <= $urandom_range(8, 0);
      `uvm_send(req)
    end
  endtask // body

endclass // random_response_seq
