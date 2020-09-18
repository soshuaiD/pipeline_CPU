`timescale 1ns / 1ps
`include "const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/17 20:24:52
// Design Name: 
// Module Name: cpu_top
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



module cpu_top(
    input wire clk,
    input wire rst
    );

//stage 1: fetch instruction
//include module: PC , PFU , IMem   
wire [31:0] PCin;
wire [31:0] PCout;
wire pause;

PC U_PC(
	.clk(clk),
	.rst(rst),
	.PCin(PCin),

	.PCout(PCout)
	);

wire[31:0] instruction;

IMem U_IMem(
	.instruction_addr(PCin),

	.instruction(instruction)
	);

wire [31:0] instruction_out;

IF_ID U_IF_ID(
	.clk(clk),
	.rst(rst),
	.InstIn(instruction),
	.pause(pause),

	.InstOut(instruction_out)
	);

//Stage 2:instrution decode
//include modules:instruction decoder, control unit, register file, reg_dst_mux, extend, branch_judge
wire [25:0] instr_index;
wire [5:0] opcode;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [4:0] sa;
wire [5:0] func;
wire [15:0] imm_16;

instr_decoder u_instr_decoder(
	.InstIn(InstOut),
    
    .instr_index(instr_index),
    .opcode(opcode),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .sa(sa),
    .func(func),
    .immediate(imm_16)
	);

wire reg_we;
wire [4:0] write_addr;
wire [4:0] write_data;
wire [31:0] reg_data1;
wire [31:0] reg_data2;

reg_file u_reg_file(
    .clk(clk),
    .rst(rst),
    .read_addr1(rs),
    .read_addr2(rt),
    .reg_we(reg_we),
    .write_addr(write_addr),
    .write_data(write_data),

    .read_data1(reg_data1),
    .read_data2(reg_data2),
    .pause(pause)
    );

wire[31:0] PCplus8;

PFU u_PFU(
	.PCold(PCout),
	.imm_16(imm_16),
	.imm_26(instr_index),
	.rs_data(reg_data1),
	.PCsrc(PCsrc),

	.PCnew(PCin),
	.PCplus8(PCplus8)
	);

wire[`ALU_OP_LENGTH-1:0] branch_control;
wire[`BRANCH_LENGTH-1:0] zero;
branch_judge u_branch_judge(
        .rs_data(reg_data1),
        .rt_data(reg_data2),
        
        .branch_control(branch_control),
        .result(zero)
    );

wire[`PFU_OP_LENGTH-1:0] PCsrc;
wire [`WDATA_SRC_LENGTH-1:0] WriteDataSrc;
wire [`REG_DST_LENGTH-1:0] WriteRegSrc;
wire DataMemWe;
wire [`ALUopnd1_LENGTH-1:0] ALUopnd1src;
wire [`ALUopnd2_LENGTH-1:0] ALUopnd2src;
wire RegWE;
wire [`EXTEND_LENGTH:0] ExtOp;
wire pause_out;

control_unit u_control_unit(
    .opcode(opcode),
    .rt_code(rt),
    .rd_zero(rd),
    .func(func),
    .zero(zero),
    .pause_in(pause),
    
    .PCsrc(PCsrc),
    .WriteDataSrc(WriteDataSrc),
    .WriteRegSrc(WriteRegSrc),
    .DataMemWe(DataMemWe),
    .ALUop(branch_control),
    .ALUopnd1src(ALUopnd1src),
    .ALUopnd2src(ALUopnd2src),
    .RegWE(RegWE),
    .ExtOp(ExtOp),
    .pause_out(pause_out)
    );

wire[4:0] reg_dst;

reg_dst_mux u_reg_dst_mux(
	.rt(rt),
	.rd(rd),
	.WriteRegSrc(WriteRegSrc),

	.reg_dst(reg_dst)
	);

wire[31:0] ext_data;

extend u_extend(
	.ExtOp(ExtOp),
	.data(imm_16),

	.ext_data(ext_data)
	);

 wire [1:0] WriteDataSrc_out;
 wire DataMemWE_out;
 wire [3:0] alu_op_out;
 wire [1:0] ALUopnd1src_out;
 wire [1:0] ALUopnd2src_out;
 wire [31:0] reg1data_out;
 wire [31:0] reg2data_out;
 wire [4:0] reg_write_add_out;
 wire [4:0] sa_out;
 wire [31:0] extended_data_out;

ID_EXE u_ID_EXE(
    .clk(clk),
    .rst(rst),
    .WriteDataSrc_in(WriteDataSrc),
    .alu_op_in(ALUop),
    .ALUopnd1src_in(ALUopnd1src),
    .ALUopnd2src_in(ALUopnd2src),
    .DataMemWE_in(DataMemWe),
    .pause(pause_out),
    .reg1data_in(reg_data1),
    .reg2data_in(reg_data2),
    .reg_write_addr_in(reg_dst),
    .sa_in(sa),
    .extended_data_in(ext_data),
    
    .WriteDataSrc_out(WriteDataSrc_out),
    .DataMemWE_out(DataMemWE_out),
    .alu_op_out(alu_op_out),
    .ALUopnd1src_out(ALUopnd1src_out),
    .ALUopnd2src_out(ALUopnd2src_out),
    .reg1data_out(reg1data_out),
    .reg2data_out(reg2data_out),
    .reg_write_addr_out(reg_write_addr_out),
    .sa_out(sa_out),
    .extended_data_out(extended_data_out)
    );


//Stage 3: execution
//include modules: ALU_opnd1_mux, ALU_opnd2_mux, MEM_WB
 wire[31:0] ALU_opnd1;

 ALU_opnd1_mux u_ALU_opnd1_mux(
		.sa(sa_out),
		.regData(reg1data_out),
		.ALUopnd1src(ALUopnd1src_out),

		.ALU_opnd1(ALU_opnd1)
	);

wire[31:0] ALU_opnd2;

ALU_opnd2_mux u_ALU_opnd2_mux(
		.regData(reg2data_out),
		.imm_32(extended_data_out),
		.ALUopnd2src(ALUopnd2src_out),

		.ALU_opnd2(ALU_opnd2)
	);

wire[31:0] ALURes;

ALU u_ALU(
    .ALUop(alu_op_out),
    .ALUopnd1(ALU_opnd1),
    .ALUopnd2(ALU_opnd2),

    .ALURes(ALURes)
);

EXE_MEM u_EXE_MEM(
	.clk(clk),
    .rst(rst),
    .DataMemWE(DataMemWE_out), //读使能
    .pauseOut(pause_out),  //停止
    .WriteDataSrc(), //数据来源
    .ALURes(ALURes),
    .Reg2DataOut(reg2data_out),
    .RegisterFile(),

    //传出信号
    .DataMemWE_out(),
    .WriteDataSrc_out(),
    .ALURes_out(),
    .RegisterFile_out(),
    .Reg2DataOut_out(),
	);



endmodule
