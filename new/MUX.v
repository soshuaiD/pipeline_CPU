`timescale 1ns / 1ps
`include "const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/17 14:34:49
// Design Name: 
// Module Name: MUX
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


module reg_dst_mux(
		input wire[4:0] rt,
		input wire[4:0] rd,
		input wire[`REG_DST_LENGTH - 1:0] WriteRegSrc,

		output wire[4:0] reg_dst
    );

assign reg_out = (WriteRegSrc == `WRITE_REG_RT    ) ? rt :
       			 (WriteRegSrc == `WRITE_REG_RD    ) ? rd :
       			 (WriteRegSrc == `WRITE_REG_31) ? `REG_31_ADDR : `INIT_32;
endmodule

module ALU_opnd1_mux(
		input wire[4:0] sa,
		input wire[31:0] regData,
		input wire[`ALUopnd1_LENGTH-1:0] ALUopnd1src,

		output wire[31:0] ALU_opnd1
	);
assign ALU_opnd1 = (ALUopnd1src==`ALUopnd1_SA) ? {{27{sa[4]}},sa}:
				   (ALUopnd1src==`ALUopnd1_RS) ? regData : `INIT_32;

endmodule

module ALU_opnd2_mux(
		input wire[31:0] regData,
		input wire[31:0] imm_32,
		input wire[`ALUopnd2_LENGTH-1:0]  ALUopnd2src,

		output wire[31:0] ALU_opnd2
	);
assign ALU_opnd2 = (ALUopnd2src==`ALUopnd2_RT) ? regData:
				   (ALUopnd2src==`ALUopnd2_IMM) ? imm_32: `INIT_32;
endmodule

module reg_src_mux(
	input wire[31:0] ALURes,
	input wire[31:0] MemData,
	input wire [31:0] PCplus8,
	input wire [`WDATA_SRC_LENGTH-1:0] reg_src_signal,

	output wire[31:0] mux_out
	);
assign mux_out = (reg_src_signal==`WDATA_SRC_ALU) ? ALURes:
				 (reg_src_signal==`WDATA_SRC_DMEM) ? MemData:
				 (reg_src_signal==`WDATA_SRC_PCplus8) ? PCplus8 : `INIT_32;
endmodule