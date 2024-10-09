`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2022 02:52:51 PM
// Design Name: 
// Module Name: datapath_tb
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

module datapath_tb(
`include "param.v"

	// Inputs
	reg clk;
	reg reset;
	reg [DATA_BUS_WIDTH-1:0] mem_data;

	integer i ;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.clk(clk),
		.reset(reset), 
		.mem_data(mem_data) 
	);

	wire [STATE_BITS-1:0] state ;
	wire [STATE_BITS-1:0] next_state ;
	wire [INSTRUCTION_WIDTH-1:0] instr ;
	wire [DATA_BUS_WIDTH-1:0] r1 ;
	wire [DATA_BUS_WIDTH-1:0] r2 ;
	wire [DATA_BUS_WIDTH-1:0] db ;
	wire [4:0] aluOP ;
        wire [4:0] ra ;

	assign state = uut.control.state ;
	assign next_state = uut.control.next_state ;
	// assign instr = uut.iregister.instruction ;
	assign instr = uut.instruction ;
	assign r1 = uut.reg1.reg_data[1] ;
	assign r2 = uut.reg1.reg_data[2] ;
	assign aluOP = uut.aluOP ;
	assign db = uut.databus ;
	assign ra = uut.read1_addr ;

	initial begin
	        $dumpfile ( "datapath.vcd" ) ;
	        $dumpvars ;
		// Initialize Inputs
		clk = 0;
		reset = 0;
		mem_data = 'h3040014 ;
		#100;
		$display("%d %b %b %x %d %d %b %d %x %d %d", $stime, clk, reset, mem_data, 
		  uut.control.state, uut.control.next_state, uut.ireg_enable, uut.write_imm,instr, r1, r2) ;
		$monitor("%d %b %b %x %d %d %b %d %x %d %d", $stime, clk, reset, mem_data, 
		  state, next_state,uut.ireg_enable, uut.write_imm,instr, r1, r2) ;

		for( i = 0 ; i < 3 ; i = i + 1) begin
		  reset = 1;
		  #100;
		  $display("%d %b %b %x %d %d %b %d %x %d %d", $stime, clk, reset, mem_data, 
		    state, next_state,uut.ireg_enable, uut.write_imm,instr, r1, r2) ;
		  $monitor("%d %b %b %x %d %d %b %d %x %d %d", $stime, clk, reset, mem_data, 
		    state, next_state,uut.ireg_enable, uut.write_imm,instr, r1, r2) ;
		end

		reset = 0;
		// Wait 100 ns for global reset to finish
		for( i = 0 ; i < 6 ; i = i + 1) begin
		  #100;
		  $display("%d %b %b %x %d %d %b %d %x %d %d", $stime, clk, reset, mem_data, 
		     state, next_state,uut.ireg_enable, uut.write_imm,instr, r1, r2) ;
		  $monitor("%d %b %b %x %d %d %b %d %x %d %d", $stime, clk, reset, mem_data, 
		    state, next_state,uut.ireg_enable, uut.write_imm,instr, r1, r2) ;
		end

                mem_data = 'h3080016 ;
		for( i = 0 ; i < 6 ; i = i + 1) begin
		  #100;
		  $display("%d %b %b %x %d %d %b %d %x %d %d", $stime, clk, reset, mem_data, 
		     state, next_state,uut.ireg_enable, uut.write_imm,instr, r1, r2) ;
		  $monitor("%d %b %b %x %d %d %b %d %x %d %d", $stime, clk, reset, mem_data, 
		    state, next_state,uut.ireg_enable, uut.write_imm,instr, r1, r2) ;
		end

                mem_data = 'h0882000 ;
		for( i = 0 ; i < 6 ; i = i + 1) begin
		  #100;
		  $display("%d %b %b %x %d %d %b %d %x %d %d %d", $stime, clk, reset, mem_data, 
		     state, next_state,uut.ireg_enable, uut.write_imm,instr, r1, r2, aluOP, db, ra) ;
		  $monitor("%d %b %b %x %d %d %b %d %x %d %d %d", $stime, clk, reset, mem_data, 
		    state, next_state,uut.ireg_enable, uut.write_imm,instr, r1, r2, aluOP, db, ra) ;
		end
        
		#100 $finish ;



	end

	always #100 clk = !clk ;
      
endmodule
    );
endmodule
