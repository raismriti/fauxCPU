`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2022 03:00:03 PM
// Design Name: 
// Module Name: mux
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


module mux(
    data0, 
    data1, 
    data_out,
    sel
  ) ;

  `include "param.v"

  input [DATA_BUS_WIDTH-1:0] data0 ;
  input [DATA_BUS_WIDTH-1:0] data1 ;
  output reg [DATA_BUS_WIDTH-1:0] data_out ;
  input sel ;

  always @ ( * ) begin
    if ( sel )
      data_out <= data1 ;
    else
      data_out <= data0 ;
  end

endmodule
