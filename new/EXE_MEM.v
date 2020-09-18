`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/18 13:34:51
// Design Name: 
// Module Name: EXE_MEM
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


module EXE_MEM (
    input clk,
    input rst,
    input DataMemWE, //读使能
    input pauseOut,  //停止
    input WriteDataSrc, //数据来源
    //传入的信号

    input [31:0]ALURes,
    input [31:0]Reg2DataOut,
    input [31:0]RegisterFile,

    //传出信号
    output reg DataMemWE_out,
    output reg WriteDataSrc_out,

    output reg [31:0]ALURes_out,
    output reg [31:0]RegisterFile_out,
    output reg [31:0]Reg2DataOut_out
    
);
// always @ (posedge clk) begin
//     if (rstn) begin
//         DataMemWE_out    <= 1'b0;
//         WriteDataSrc_out <= 1'b0;
//         ALURes_out       <= `INIT_32;
//         data_out         <= `INIT_32;
//         Reg2DataOut_out  <= `INIT_32;
//     end else if (pauseOut) begin
//         DataMemWE_out    <= DataMemWE;
//         WriteDataSrc_out <= WriteDataSrc;
//         ALURes_out       <= ALURes;
//         RegisterFile_out <= RegisterFile;
//         Reg2DataOut_out  <= Reg2DataOut;
//     end 
//     // else begin
//     //     DataMemWE_out    <=
//     //     WriteDataSrc_out <=
//     //     ALURes_out       <=
//     //     data_out         <=
//     //     Reg2DataOut_out  <=
//     // end
// end
endmodule