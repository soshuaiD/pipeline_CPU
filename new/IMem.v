`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/15 19:55:51
// Design Name: 
// Module Name: IMem
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

module IMem(
        input wire[11:2] instruction_addr,
        output wire[31:0] instruction
    );
reg[31:0] imem[`IM_LENGTH:0];

initial begin
$readmemh("D://i.txt",imem);
end

assign instruction = imem[instruction_addr];

endmodule

