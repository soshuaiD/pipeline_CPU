`timescale 1ns / 1ps
`include "const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/16 09:40:41
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [5:0] opcode,
    input [4:0] rt_code,
    input [4:0] rd_zero,
    input [5:0] func,
    input [1:0] zero,
    
    input [31:0] rt_zero,
    input [1:0] pause_in,
    
    output [`PFU_OP_LENGTH-1:0] PCsrc,
    output [`WDATA_SRC_LENGTH-1:0] WriteDataSrc,
    output [`REG_DST_LENGTH-1:0] WriteRegSrc,
    output wire DataMemWe,
    output [`ALU_OP_LENGTH-1:0] ALUop,
    output [`ALUopnd1_LENGTH-1:0] ALUopnd1src,
    output [`ALUopnd2_LENGTH-1:0]ALUopnd2src,
    output wire RegWE,
    output [`EXTEND_LENGTH-1:0]ExtOp,
    output wire pause_out
    );
    
    wire instr_add, instr_addu, instr_and, instr_jr, instr_jalr;
    wire instr_movn, instr_movz, instr_nop, instr_nor, instr_or;
    wire instr_sll, instr_sllv, instr_srl, instr_srlv, instr_sra;
    wire instr_srav, instr_slt, instr_sltu, instr_sub, instr_subu;
    wire instr_xor, instr_addi, instr_addiu, instr_andi, instr_aui;
    wire instr_b, instr_beq, instr_bne, instr_bltz, instr_blez;
    wire instr_bgtz, instr_bgez, instr_lui, instr_lw, instr_ori;
    wire instr_slti, instr_sltiu, instr_sw, instr_xori, instr_bc;
    wire instr_j, instr_jal;

    assign instr_add = (opcode==`SPECIAL_OPCODE && func==`FUNC_ADD)? 1:0;
    assign instr_addu = (opcode==`SPECIAL_OPCODE && func==`FUNC_ADDU)? 1:0;
    assign instr_and = (opcode==`SPECIAL_OPCODE && func==`FUNC_AND)? 1:0;
    assign instr_jr = (opcode==`SPECIAL_OPCODE && func==`FUNC_JR_JALR && rd_zero == 5'b00000)? 1:0;
    assign instr_jalr = (opcode==`SPECIAL_OPCODE && func==`FUNC_JR_JALR && rd_zero != 5'b00000)? 1:0;
    assign instr_movn = (opcode==`SPECIAL_OPCODE && func==`FUNC_MOVN)? 1:0;
    assign instr_movz = (opcode==`SPECIAL_OPCODE && func==`FUNC_MOVZ)? 1:0;
   
    assign instr_sll = (opcode==`SPECIAL_OPCODE && func==`FUNC_NOP_SLL)? 1:0;
    assign instr_nop = (opcode==`SPECIAL_OPCODE &&rt_code == `INIT_5&&rd_zero == `INIT_5 && func==`FUNC_NOP_SLL)? 1:0;

    assign instr_nor = (opcode==`SPECIAL_OPCODE && func==`FUNC_NOR)? 1:0;
    assign instr_or = (opcode==`SPECIAL_OPCODE && func==`FUNC_OR)? 1:0;
    assign instr_sllv = (opcode==`SPECIAL_OPCODE && func==`FUNC_SLLV)? 1:0;
    assign instr_srl = (opcode==`SPECIAL_OPCODE && func==`FUNC_SRL)? 1:0;
    assign instr_srlv = (opcode==`SPECIAL_OPCODE && func==`FUNC_SRLV)? 1:0;
    assign instr_sra = (opcode==`SPECIAL_OPCODE && func==`FUNC_SRA)? 1:0;
    assign instr_srav = (opcode==`SPECIAL_OPCODE && func==`FUNC_SRAV)? 1:0;
    assign instr_slt = (opcode==`SPECIAL_OPCODE && func==`FUNC_SLT)? 1:0;
    assign instr_sltu = (opcode==`SPECIAL_OPCODE && func==`FUNC_SLTU)? 1:0;
    assign instr_sub = (opcode==`SPECIAL_OPCODE && func==`FUNC_SUB)? 1:0;
    assign instr_subu = (opcode==`SPECIAL_OPCODE && func==`FUNC_SUBU)? 1:0;
    assign instr_xor = (opcode==`SPECIAL_OPCODE && func==`FUNC_XOR)? 1:0;
    
    assign instr_addi = (opcode==`INSTR_ADDI)? 1:0;
    assign instr_addiu = (opcode==`INSTR_ADDIU)? 1:0;
    assign instr_andi = (opcode==`INSTR_ANDI)? 1:0;
    assign instr_aui = (opcode==`INSTR_AUI)? 1:0;
    
    assign instr_b = (opcode==`INSTR_B_BEQ && rt_code==`INIT_5 && rd_zero==`INIT_5)?1:0;
    assign instr_beq = (opcode==`INSTR_B_BEQ)? 1:0;
    
    assign instr_bne = (opcode==`INSTR_BNE)? 1:0;
    assign instr_bltz = (opcode==`INSTR_BLTZ_BGEZ && rt_code==5'b00000)? 1:0;
    assign instr_blez = (opcode==`INSTR_BLEZ)? 1:0;
    assign instr_bgtz = (opcode==`INSTR_BGTZ)? 1:0;
    assign instr_bgez = (opcode==`INSTR_BLTZ_BGEZ && rt_code!=5'b00001)? 1:0;
    assign instr_lui = (opcode==`INSTR_LUI)? 1:0;
    assign instr_lw = (opcode==`INSTR_LW)? 1:0;
    assign instr_ori = (opcode==`INSTR_ORI)? 1:0;
    assign instr_slti = (opcode==`INSTR_SLTI)? 1:0;
    assign instr_sltiu = (opcode==`INSTR_SLTIU)? 1:0;
    assign instr_sw = (opcode==`INSTR_SW)? 1:0;
    assign instr_xori = (opcode==`INSTR_XORI)? 1:0;
    assign instr_bc = (opcode==`INSTR_BC)? 1:0;
    assign instr_j = (opcode==`INSTR_J)? 1:0;
    assign instr_jal = (opcode==`INSTR_JAL)? 1:0;
    
    assign WriteDataSrc =   (instr_jr || instr_b || instr_beq || 
                            instr_bne || instr_bltz || instr_blez || 
                            instr_bgtz || instr_bgez || instr_sw || 
                            instr_bc || instr_j)? `WDATA_SRC_DEFAULT:
                            (instr_jalr || instr_jal)? `WDATA_SRC_PCplus8:
                            (instr_lw)? `WDATA_SRC_DMEM: `WDATA_SRC_ALU;

    assign DataMemWe = instr_sw;
    wire zhc = instr_sw;            //zhc yyyds,此处感谢大哥帮我们debug
    // assign DataMemWe = 1;
    
    assign ALUop = (instr_add || instr_addu || instr_addi ||
                      instr_addiu || instr_aui || instr_lui ||
                      instr_lw || instr_sw)? `ALU_OP_ADD:
                      (instr_and || instr_andi)? `ALU_OP_AND:
                       ((instr_movn && rt_zero!=0)|| (instr_movz && rt_zero==0))? `ALU_OP_MOV:
                      (instr_nor)? `ALU_OP_NOR:
                      (instr_or || instr_ori)? `ALU_OP_OR:
                      (instr_sll || instr_sllv)? `ALU_OP_SLL:
                      (instr_srl || instr_srlv)? `ALU_OP_SRL:
                      (instr_sra || instr_srav)? `ALU_OP_SRA:
                      (instr_slt || instr_slti)? `ALU_OP_SLT:
                      (instr_sltu || instr_sltiu)? `ALU_OP_SLTU:
                      (instr_sub || instr_subu)? `ALU_OP_SUB:
                      (instr_xor || instr_xori)? `ALU_OP_XOR:
                      (instr_beq || instr_bne)? `ALU_OP_CMP:
                      (instr_bltz || instr_blez ||
                       instr_bgtz || instr_bgez)? `ALU_OP_CMP0:`ALU_OP_DEFAULT;
                      
    assign ALUopnd1src = (instr_sll || instr_srl || instr_sra)? `ALUopnd1_SA:
                         (instr_jr || instr_jalr || instr_blez ||
                          instr_beq || instr_bne || instr_bltz ||
                          instr_blez || instr_bgtz || instr_bgez ||
                          instr_bc || instr_j || instr_jal)? `ALUopnd1_DEFAULT:`ALUopnd1_RS;

    assign ALUopnd2src = (instr_addi || instr_addiu || instr_andi ||
                          instr_aui || instr_lui || instr_lw ||
                          instr_ori || instr_slti || instr_sltiu ||
                          instr_sw || instr_xori)? `ALUopnd2_IMM:
                         (instr_jr || instr_jalr || instr_beq ||
                          instr_bne || instr_bltz || instr_blez ||
                          instr_bgtz || instr_bgez || instr_bc ||
                          instr_j || instr_jal)? `ALUopnd2_DEFAULT:`ALUopnd2_RT;

    assign RegWE = (instr_jr || instr_beq || instr_bne || instr_bltz ||
                    instr_blez || instr_bgtz || instr_bgez || instr_sw ||
                    instr_bc || instr_j)? 0:1;
                    
    assign WriteRegSrc = (instr_jal)? `WRITE_REG_31:
                         (instr_jr || instr_beq || instr_bne ||
                          instr_bltz || instr_blez || instr_bgtz ||
                          instr_bgez || instr_sw || instr_bc || instr_j)? `WRITE_REG_DEFAULT:
                         (instr_addi || instr_addiu || instr_andi ||
                          instr_aui || instr_lui || instr_lw ||
                          instr_ori || instr_slti || instr_sltiu ||
                          instr_xori)? `WRITE_REG_RT:`WRITE_REG_RD;
                          
    assign ExtOp = (instr_addi || instr_addiu || instr_lw ||
                    instr_slti || instr_sltiu || instr_sw)? `SIGN_EXTEND:
                   (instr_andi || instr_ori || instr_xori)? `ZERO_EXTEND:
                   (instr_aui || instr_lui)? `SHIFT:`DEFAULT_EXTEND;   

                         
    assign PCsrc = (instr_jr || instr_jalr)? `PFU_OP_RS:
                   (instr_j || instr_jal)? `PFU_OP_JUMP:
                   (instr_bc)? `PFU_OP_OFFSET_26:
                   ((instr_beq && zero==`BRANCH_EQUAL)||
                    (instr_bne && zero!=`BRANCH_EQUAL)||
                    (instr_bltz && zero==`BRANCH_LT)||
                    (instr_blez && zero!=`BRANCH_GT)||
                    (instr_bgtz && zero==`BRANCH_GT)||
                    (instr_bgez && zero!=`BRANCH_LT))? `PFU_OP_OFFSET_16:`PFU_OP_NEXT;
                    
    assign pause_out = ((instr_add||instr_addu||instr_and||instr_movn||
                         instr_movz||instr_nor||instr_or||instr_sllv||
                         instr_srlv||instr_srav||instr_slt||instr_sltu||
                         instr_sub||instr_subu||instr_xor||instr_beq||
                         instr_bne)&&(pause_in!=`PAUSE_NO))? 1:
                       ((instr_addi||instr_addiu||instr_andi||instr_aui||
                         instr_bltz||instr_blez||instr_bgtz||instr_bgez||
                         instr_lui||instr_lw||instr_ori||instr_slti||
                         instr_sltiu||instr_sw||instr_xori)
                         &&(pause_in==`PAUSE_RS))? 1:
                       ((instr_sll||instr_srl||instr_sra)
                         &&(pause_in==`PAUSE_RT))? 1:0;

                                      
endmodule
