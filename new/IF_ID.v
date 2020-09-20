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

   		output wire[31:0] InstOut
    );

reg [31:0] Inst;

always @(posedge clk) begin
	if (!rst) begin
		Inst <= `INIT_32;
	end
	else if(!pause) begin
		Inst <= InstIn;
	end
end

assign InstOut = Inst;
endmodule
