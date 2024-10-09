
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2022 02:57:55 PM
// Design Name: 
// Module Name: multi_control
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

`timescale 1ns / 1ps

module multi_control(
    clk,
    reset,
    opcode,
    imm_mux,
    ireg_enable,
    write_enable,
    imm_mux,
    aluOP
    );
    
`include "param.v"

    input clk ;
    input reset ;
    input [4:0] opcode ;
    output reg ireg_enable ;
    output reg write_enable ;
    output reg imm_mux ;
    output reg [4:0] aluOP ;

    reg [STATE_BITS-1:0] state ;
    reg [STATE_BITS-1:0] next_state ;

    always @ ( posedge clk )
      if( reset )
	state <= STATE_FETCH ;
      else
	state <= next_state ;

    always @ ( state or opcode ) begin
      next_state <= 'bX ;
      ireg_enable <= 0 ;
      write_enable <= 0 ;
      imm_mux <= 1 ;
      case ( state )
	STATE_FETCH: begin
	  next_state <= STATE_DECODE ;
	  ireg_enable <= 1 ;

	end

	STATE_DECODE: begin
	  next_state <= STATE_EXEC ;
	  write_enable <= 1 ;
	  aluOP <= OP_DIVIDE ;
	  case (opcode)
	    INSTR_ADD: begin
	      aluOP <= OP_ADD ;
	    end
	    INSTR_LI: begin
	      imm_mux <= 0 ;
	      next_state <= STATE_FETCH ;
	    end
	    default: begin
	      imm_mux <= 1 ;
	    end
	  endcase
	end

	STATE_EXEC: begin
	  next_state <= STATE_FETCH ;
	  if( opcode == INSTR_ADD ) begin
	    imm_mux <= 1 ;
	    write_enable <= 1 ;
	  end

	end



      endcase
