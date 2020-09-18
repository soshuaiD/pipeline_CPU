`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/18 13:24:14
// Design Name: 
// Module Name: ALU
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
module ALU (
    input [4:0] ALUop,
    input [31:0] ALUopnd1,
    //rs或sa
    input [31:0] ALUopnd2,
    //rt或扩展单�?
    output [31:0] ALURes
);
endmodule


