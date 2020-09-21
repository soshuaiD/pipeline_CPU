`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/16 15:19:35
// Design Name: 
// Module Name: MEM_WB
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

module MEM_WB(
    input wire       clk,
    input wire       rst,
    input wire[31:0] dataMemIn,
    input wire[31:0] ALUResIn,
    input wire[31:0] PCplus8In,
    input wire[1:0]  WriteDataSrcIn,
    input wire[4:0]  WriteRegAddrIn,
    input wire RegWE,

    output reg[31:0] dataMemOut,
    output reg[31:0] ALUResOut,
    output reg[31:0] PCplus8Out,
    output reg[1:0]  WriteDataSrcOut,
    output reg[4:0]  WriteRegAddrOut,
    output reg RegWE_out
    );

    always @(posedge clk) begin
        if (!rst) begin
            // reset
            dataMemOut <= `INIT_32;
            ALUResOut <= `INIT_32;
            PCplus8Out <= `INIT_32;
            WriteDataSrcOut <= `INIT_2;
            WriteRegAddrOut <= `INIT_5;
            RegWE_out       <= 1'b0;
        end
        else begin
            dataMemOut <= dataMemIn;
            ALUResOut <= ALUResIn;
            PCplus8Out <= PCplus8In;
            WriteDataSrcOut <= WriteDataSrcIn;
            WriteRegAddrOut <= WriteRegAddrIn;
            RegWE_out       <= RegWE;
        end
    end
endmodule
