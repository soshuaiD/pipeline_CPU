`timescale 1ns / 1ps

`include "const.vh"

module PFU(
    input wire[31:0] PCold,
    input wire[15:0] imm_16,
    input wire[25:0] imm_26,
    input wire[31:0] rs_data,
    input wire[`PFU_OP_LENGTH-1:0] PCsrc,

    output wire[31:0] PCnew,
    output wire [31:0] PCplus8
);

assign PCplus8 = PCold + 32'h8;
assign PCnew = (PCsrc == `PFU_OP_NEXT)? PCold+32'h4 :
			   (PCsrc == `PFU_OP_JUMP) ?{PCold[31:28], imm_26, 2'b00}:
			   (PCsrc == `PFU_OP_OFFSET_16)? (PCold+32'h4 + {{14{imm_16[15]}}, imm_16[15:0], 2'b0}):
               (PCsrc == `PFU_OP_OFFSET_26)? (PCold+32'h4 + {{4{imm_26[25]}}, imm_26[25:0], 2'b0}):
			   (PCsrc == `PFU_OP_RS)?rs_data:
			   PCold+32'h4;
endmodule