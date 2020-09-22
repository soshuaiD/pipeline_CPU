`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/16 14:32:37
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input clk,
    input rst,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input RegWE,
    input [4:0] write_addr,
    input [4:0] collision_addr,
    input [31:0] write_data,
    input [`ALUopnd2_LENGTH-1:0] ALUopnd2src,
    input [5:0] opcode,

    output [31:0] read_data1,
    output [31:0] read_data2,
    output [1:0] pause
    );
    
    reg [4:0] buffer1;
    reg [4:0] buffer2;
    reg [4:0] buffer3;
    reg [31:0] registers [31:0];

    integer i;
    always @(posedge clk) begin
        if (!rst) begin
            // reset
          for(i=0;i<32;i=i+1)
          begin
              registers[i]=`INIT_32;
          end
        end
    end

    always @(posedge clk)
    begin
        if (!rst)
        begin 
            buffer1 <= 0;
            buffer2 <= 0;
            buffer3 <= 0;
        end
        else
        begin
            buffer1 <= collision_addr;
            buffer2 <= buffer1;
            buffer3 <= buffer2;
        end
    end
    
    always @(posedge clk)
    begin
        if (RegWE)
        begin
            registers[write_addr] <= write_data;
        end
    end
    
    assign read_data1 = registers[read_addr1];
    assign read_data2 = registers[read_addr2];
    
    wire pause_rs, pause_rt;
    wire collision1 = (buffer1==read_addr1||
                        buffer2==read_addr1||
                        buffer3==read_addr1);
    assign pause_rs = (collision1 && (read_addr1!=0))? 1:0;

    wire collision2 = (buffer1==read_addr2||buffer2==read_addr2||buffer3==read_addr2);
    assign pause_rt = (collision2 && (read_addr2!=0) && (ALUopnd2src==`ALUopnd2_RT||opcode==6'b000101||opcode==6'b000100))? 1:0;

    // wire [`PAUSE_LENGTH-1:0] pause_tmp = (pause_rs && pause_rt)? `PAUSE_BOTH:
    //                                      (pause_rs)? `PAUSE_RS:
    //                                      (pause_rt)? `PAUSE_RT:`PAUSE_NO;
    // wire [`PAUSE_LENGTH-1:0] pause_tmp = (pause_rs == 1 && pause_rt == 1)? 2'b11:
    //                                      (pause_rs == 1)? 2'b10:
    //                                      (pause_rt == 1)? 2'b01:2'b00;
    assign pause = {pause_rt,pause_rs};
    wire [`PAUSE_LENGTH-1:0] zgz = pause;
    wire [4:0]temp = read_addr1;
endmodule
