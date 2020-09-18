`timescale 1ns / 1ps
`include "const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/16 14:05:53
// Design Name: 
// Module Name: extend
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


module extend(
    input [`EXTEND_LENGTH-1:0] ExtOp,
    input [15:0] data,
    output [31:0] ext_data
    );
    
    assign ext_data = (ExtOp==`ZERO_EXTEND)? {{16{1'b0}}, data}:
                      (ExtOp==`SIGN_EXTEND)?{{16{data[15]}}, data}:
                      {{16{data[15]}}, data}<<16;
endmodule
