`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/16 09:21:35
// Design Name: 
// Module Name: instr_decoder
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


module instr_decoder(
    input [31:0] InstIn,
    
    output [25:0] instr_index,
    output [5:0] opcode,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] sa,
    output [5:0] func,
    output [15:0] immediate
    );
    
    assign instr_index = InstIn[25:0];
    assign opcode = InstIn[31:26];
    assign rs = InstIn[25:21];
    assign rt = InstIn[20:16];
    assign rd = InstIn[15:11];
    assign sa = InstIn[10:6];
    assign func = InstIn[5:0];
    assign immediate = InstIn[15:0];
endmodule
