`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/15 21:26:52
// Design Name: 
// Module Name: IF_ID
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
`include "const.vh"

module IF_ID(
   		input wire clk,
   		input wire rst,
   		input wire[31:0] InstIn,
   		input wire pause,

   		output reg[31:0] InstOut
    );

always @(posedge clk or posedge rst) begin
	if (!rst || pause) begin
		InstOut = `INIT_32;
	end
	else begin
		InstOut = InstIn;
	end
end
endmodule
