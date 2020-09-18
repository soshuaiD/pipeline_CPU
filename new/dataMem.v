`timescale 1ns / 1ps
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
    input wire DataMemWE,
    input wire[31:0] DataMemAddr,
    input wire[31:0] DataMemIn,
    output wire[31:0] DataMemOut
    );
    reg[31:0] data_mem[1023:0];
    assign DataMemOut = data_mem[DataMemAddr[11:2]];

    always @(posedge clk) begin
        if (DataMemWE) begin
            data_mem[DataMemAddr[11:2]] <= DataMemIn;
        end
    end
endmodule
