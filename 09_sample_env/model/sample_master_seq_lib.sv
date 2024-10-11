virtual class sample_master_base_seq extends uvm_sequence #(sample_seq_item);
  function new(string name="sample_master_base_seq");
    super.new(name);
    do_not_randomize = 1;
    set_automatic_phase_objection(1);
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
class write_seq extends sample_master_base_seq;
  bit [ 7: 0] addr, data;

  `uvm_object_utils(write_seq)

  function new (string name="write_seq");
    super.new(name);
  endfunction // new

  virtual task body();
    `uvm_create(req)
    req.write <= 1'b1;
    req.addr  <= this.addr;
    req.wdata <= this.data;
    `uvm_send(req)
  endtask // body

endclass // write_seq

class read_seq extends sample_master_base_seq;
  bit [ 7: 0] addr, rdata;

  `uvm_object_utils(read_seq)

  function new (string name="read_seq");
    super.new(name);
  endfunction // new

  virtual task body();
    `uvm_create(req)
    req.write  = 1'b0;
    req.addr   = this.addr;
    `uvm_send(req)
    this.rdata = req.rdata;
  endtask // body

endclass // read_seq


class write_read_seq extends sample_master_base_seq;
  write_seq _write;
  read_seq  _read;

  `uvm_object_utils(write_read_seq)

  function new (string name="write_read_seq");
    super.new(name);
  endfunction // new

  virtual task body();
    bit [7:0] addr, data;
    addr = 8'h10;
    data = 8'h5A;

    `uvm_create(_write)
    _write.addr = addr;
    _write.data = data;
    `uvm_send(_write)

    `uvm_create(_read)
    _read.addr  = addr;
    `uvm_send(_read)
  endtask // body

endclass // write_read_seq

class write_read_all_seq extends sample_master_base_seq;
  write_seq _write;
  read_seq  _read;
  `uvm_object_utils(write_read_all_seq)

  function new (string name="write_read_all_seq");
    super.new(name);
  endfunction // new

  virtual task body();
    int i;
    for(i=0; i<256; i=i+1)begin
      `uvm_create(_write)
      _write.addr = i;
      _write.data = $urandom_range(255,0);
      `uvm_send(_write)
    end
    for(i=0; i<256; i=i+1)begin
      `uvm_create(_read)
      _read.addr = i;
      `uvm_send(_read)
    end
  endtask // body

endclass // write_read_all_seq
