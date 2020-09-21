`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/17 11:30:41
// Design Name: 
// Module Name: reg_id_exe
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
module ID_EXE(
    input clk,
    input rst,
    input [`WDATA_SRC_LENGTH-1:0] WriteDataSrc_in,
    input [`ALU_OP_LENGTH-1:0] alu_op_in,
    input [`ALUopnd1_LENGTH-1:0] ALUopnd1src_in,
    input [`ALUopnd2_LENGTH-1:0] ALUopnd2src_in,
    input DataMemWE_in,
    input pause,
    
    input [31:0] reg1data_in,
    input [31:0] reg2data_in,
    input [4:0] reg_write_addr_in,
    input [4:0] sa_in,
    input [31:0] extended_data_in,
    input RegWE,
    
    output [1:0] WriteDataSrc_out,
    output DataMemWE_out,
    output [3:0] alu_op_out,
    output [1:0] ALUopnd1src_out,
    output [1:0] ALUopnd2src_out,
    output [31:0] reg1data_out,
    output [31:0] reg2data_out,
    output [4:0] reg_write_addr_out,
    output [4:0] sa_out,
    output [31:0] extended_data_out,
    output wire RegWE_out
    );
    
    reg [1:0] WriteDataSrc;
    reg [3:0] alu_op;
    reg [1:0] ALUopnd1src;
    reg [1:0] ALUopnd2src;
    reg DataMemWE;
    
    reg [31:0] reg1data;
    reg [31:0] reg2data;
    reg [4:0] reg_write_addr;
    reg [4:0] sa;
    reg [31:0] extended_data;
    reg RegWE_temp;
    
    always @(posedge clk)
    begin
        if (!rst||pause) 
        begin
            WriteDataSrc <= `WDATA_SRC_DEFAULT;
            alu_op <= `ALU_OP_DEFAULT;
            ALUopnd1src <= `ALUopnd1_DEFAULT;
            ALUopnd2src <= `ALUopnd2_DEFAULT;
            DataMemWE <= 0;
    
            reg1data <= `INIT_32;
            reg2data <= `INIT_32;
            reg_write_addr <= `INIT_5;
            sa <= `INIT_5;
            extended_data <= `INIT_5;
            RegWE_temp <= 1'b0;
        end
        else
        begin
            WriteDataSrc <= WriteDataSrc_in;
            alu_op <= alu_op_in;
            ALUopnd1src <= ALUopnd1src_in;
            ALUopnd2src <= ALUopnd2src_in;
            DataMemWE <= DataMemWE_in;
    
            reg1data <= reg1data_in;
            reg2data <= reg2data_in;
            reg_write_addr <= reg_write_addr_in;
            sa <= sa_in;
            extended_data <= extended_data_in;
            RegWE_temp <= RegWE;
        end
    end
    
    assign WriteDataSrc_out = WriteDataSrc;
    assign alu_op_out = alu_op;
    assign ALUopnd1src_out = ALUopnd1src;
    assign ALUopnd2src_out = ALUopnd2src;
    assign DataMemWE_out = DataMemWE;
    assign reg1data_out = reg1data;
    assign reg2data_out = reg2data;
    assign reg_write_addr_out = reg_write_addr;
    assign sa_out = sa;
    assign extended_data_out = extended_data;
    assign RegWE_out = RegWE_temp;
endmodule
