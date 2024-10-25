`define ADDR_WIDTH 8
`define DATA_WIDTH 16
`define DEPTH (2 ** `ADDR_WIDTH)

`include "reg_item.sv"
`include "driver.sv"
`include "monitor.sv"
`include "sequence.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "env.sv"
