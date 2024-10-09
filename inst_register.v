`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2022 02:56:11 PM
// Design Name: 
// Module Name: inst_register
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

module inst_register( 
    clk, 
    in_data, 
    instruction,
    en
  ) ;

  `include "param.v"

  input clk ;
  input [DATA_BUS_WIDTH-1:0] in_data ;
  output reg [INSTRUCTION_WIDTH-1:0] instruction ;
  input en ;

  always @ (posedge clk) begin
    if ( en )
      instruction[INSTRUCTION_WIDTH-1:0] <= in_data ;
  end

endmodule