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
        input [31:0] rs_data,
        input [31:0] rt_data,
        
        input [4:0] branch_control,
        output [1:0] result
    );
    assign rt_data = (branch_control==`ALU_OP_CMP0)? `INIT_32:rt_data;
    assign result = (rs_data == rt_data)? `BRANCH_EQUAL:
                    (rs_data < rt_data)? `BRANCH_LT:
                    (rs_data > rt_data)? `BRANCH_GT:`BRANCH_DEFAULT;
    /*
    assign result = (branch_control==`BRANCH_OP_CMP && rs_data==rt_data)? `BRANCH_EQUAL:
                    (branch_control==`BRANCH_OP_CMP && rs_data!=rt_data)? `BRANCH_NOTEQUAL:
                    (branch_control==`BRANCH_OP_CMP0 && rs_data < 0)? `BRANCH_LTZERO:
                    (branch_control==`BRANCH_OP_CMP0 && rs_data > 0)? `BRANCH_GTZERO:`BRANCH_DEFAULT;
    */
endmodule
