`timescale 1ns / 1ps
`include "const.vh"
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


module EXE_MEM(
    input clk,
    input rst,
    input DataMemWE,
    // input pause, 
    input [`WDATA_SRC_LENGTH-1:0]WriteDataSrc, 
    input [31:0]ALURes,
    input [31:0]Reg2DataOut,
    input [4:0]WriteRegSrc,

    output reg DataMemWE_out,
    output reg [`WDATA_SRC_LENGTH-1:0] WriteDataSrc_out,
    output reg [31:0]ALURes_out,
    output reg [4:0]WriteRegSrc_out,
    output reg [31:0]Reg2DataOut_out
    
);

always @ (posedge clk) begin
    if (!rst) begin
        DataMemWE_out    <= 1'b0;
        WriteDataSrc_out <= `INIT_2;
        ALURes_out       <= `INIT_32;
        WriteRegSrc_out  <= `INIT_32;
        Reg2DataOut_out  <= `INIT_32;
    end else begin
        DataMemWE_out    <= DataMemWE;
        WriteDataSrc_out <= WriteDataSrc;
        ALURes_out       <= ALURes;
        WriteRegSrc_out <= WriteRegSrc;
        Reg2DataOut_out  <= Reg2DataOut;
    end 
    // else begin
    //     DataMemWE_out    <=
    //     WriteDataSrc_out <=
    //     ALURes_out       <=
    //     data_out         <=
    //     Reg2DataOut_out  <=
    // end
end
endmodule