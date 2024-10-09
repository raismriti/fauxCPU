`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2022 02:43:30 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input [35:0] write_data,
    input [4:0] write_addr,
    output reg [35:0] read1,
    output reg [35:0] read2,
    input [4:0] read1_addr,
    input [4:0] read2_addr,
    input write_enable,
    input clk
    );
	 
	 integer i ;
	 reg [35:0] reg_data [31:0] ;
	 always @ ( posedge clk ) begin
	    if( write_enable ) begin
	      reg_data[write_addr] <= write_data ;
	    end

	    if ( read1_addr == 0 )
	      read1 <= 0 ;
	    else 
	      read1 <= reg_data[read1_addr] ;

	    if( read2_addr == 0 )
	      read2 <= 0 ;
	    else 
	      read2 <= reg_data[read2_addr] ;
	      