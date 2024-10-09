`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2022 02:43:05 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input [35:0] in1,
    input [35:0] in2,
    output reg [35:0] out,
    input [4:0] op,
    output reg [3:0] flags,
    output reg Cout
    );

`include "param.v"

    always @ ( op or in1 or in2  ) begin
	    case ( op )
		 OP_ADD : {Cout,out} <= in1 + in2 ;
		 OP_SUB : {Cout,out} <= in1 - in2 ;
		 OP_AND : out <= in1 & in2 ;
		 OP_OR : out <= in1 | in2 ;
		 OP_EQUAL: begin
		    if( in1 == in2 ) 
			    out <= 1 ;
			 else 
			    out <= 0 ;
		 end
		 OP_DIVIDE:
		         {Cout,out} <= in1 / in2 ;
		 
		
		 
		 endcase  
	 
