`timescale 1ns / 1ps
`include "const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/16 15:06:25
// Design Name: 
// Module Name: dataMem
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


module dataMem(
    input wire clk,
    input wire DataMemWe,
    input wire[31:0] DataMemAddr,
    input wire[31:0] DataMemIn,
    output wire[31:0] DataMemOut
    );
    reg[31:0] data_mem[1023:0];
    initial begin
        $readmemh("D://d.txt",data_mem);
    end
    assign DataMemOut = data_mem[DataMemAddr[11:2]];

    always @(posedge clk) begin
        if (DataMemWe) begin
            data_mem[DataMemAddr[11:2]] <= DataMemIn;
        end
        else begin
            data_mem[DataMemAddr[11:2]] <= `INIT_32;
        end
    end
endmodule
