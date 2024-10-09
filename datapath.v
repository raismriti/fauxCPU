`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2022 02:22:25 PM
// Design Name: 
// Module Name: datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module datapath(
    input clk,
    input reset,
    input [35:0] mem_data
    );

   `include "param.v"
   
   wire [DATA_BUS_WIDTH-1:0] databus ;
   wire [DATA_BUS_WIDTH-1:0] alu_in1 ;
   wire [DATA_BUS_WIDTH-1:0] alu_in2 ;
   wire [DATA_BUS_WIDTH-1:0] write_data ;
   wire [4:0] read1_addr ;
   wire [4:0] read2_addr ;
   wire [IMMEDIATE_WIDTH-1:0] write_imm ;
   wire [INSTRUCTION_WIDTH-1:0] instruction ;
   wire write_enable ;
   wire ireg_enable ;
   wire [4:0] opcode ;
   wire [4:0] aluOP ;
   wire [3:0] flags ;

   inst_register iregister( .clk(clk), .in_data(mem_data), 
                           .instruction(instruction), .en(ireg_enable) ) ;

   decode_instruction decode( .instruction(instruction), .reg_source(read1_addr),
                              .reg_dest(read2_addr), .opcode(opcode), .immediate(write_imm) ) ;

   regfile reg1 ( .write_addr(read2_addr), .write_data(write_data), 
                  .read1_addr(read1_addr), .read2_addr(read2_addr),
                  .read1(alu_in1), .read2(alu_in2), 
		  .write_enable(write_enable), .clk(clk) ) ;

   ALU alu1 ( .out(databus), .in1(alu_in1), .in2(alu_in2), .op(aluOP), .flags(flags) ) ; 

   multi_control control( .clk(clk), .reset(reset), .opcode(opcode), 
                          .imm_mux(imm_mux), .ireg_enable(ireg_enable),
			  .write_enable(write_enable), .aluOP(aluOP) ) ;

   mux2_36 write_mux( .data0({28'b0,write_imm}), .data1(databus), 
                      .data_out(write_data), .sel(imm_mux) ) ; 