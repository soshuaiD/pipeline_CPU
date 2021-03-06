`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/17 10:41:09
// Design Name: 
// Module Name: branch_judege
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


module branch_judge(
        input signed [31:0] rs_data,
        input signed [31:0] rt_data,
        input [`ALU_OP_LENGTH-1:0] branch_control,
        
        output [1:0] zero
    );
    wire signed [31:0] rt_data_temp = (branch_control == `ALU_OP_CMP0)? `INIT_32:rt_data;
    assign zero = 
                    (rs_data == rt_data_temp)? `BRANCH_EQUAL:
                    (rs_data < rt_data_temp)? `BRANCH_LT:
                    (rs_data > rt_data_temp)? `BRANCH_GT:`BRANCH_DEFAULT;
    /*
    assign result = (branch_control==`BRANCH_OP_CMP && rs_data==rt_data)? `BRANCH_EQUAL:
                    (branch_control==`BRANCH_OP_CMP && rs_data!=rt_data)? `BRANCH_NOTEQUAL:
                    (branch_control==`BRANCH_OP_CMP0 && rs_data < 0)? `BRANCH_LTZERO:
                    (branch_control==`BRANCH_OP_CMP0 && rs_data > 0)? `BRANCH_GTZERO:`BRANCH_DEFAULT;
    */
endmodule
