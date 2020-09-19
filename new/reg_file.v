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
    input reg_we,
    input [4:0] write_addr,
    input [31:0] write_data,

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

    always @(posedge clk or negedge rst)
    begin
        if (!rst)
        begin 
            buffer1 <= 0;
            buffer2 <= 0;
            buffer3 <= 0;
        end
        else
        begin
            buffer1 <= write_addr;
            buffer2 <= buffer1;
            buffer3 <= buffer2;
        end
    end
    
    always @(posedge clk)
    begin
        if (reg_we)
        begin
            registers[write_addr] <= write_data;
        end
    end
    
    assign read_data1 = registers[read_addr1];
    assign read_data2 = registers[read_addr2];
    
    wire pause_rs, pause_rt;
    assign pause_rs = ((buffer1==read_addr1||buffer2==read_addr1||buffer3==read_addr1)
                        && (read_addr1!=0))? 1:0;
    assign pause_rt = ((buffer1==read_addr2||buffer2==read_addr2||buffer3==read_addr2)
                        && (read_addr2!=0))? 1:0;
    assign pause = (pause_rs && pause_rt)? `PAUSE_BOTH:
                   (pause_rs)? `PAUSE_RS:
                   (pause_rt)? `PAUSE_RT:`PAUSE_NO;
                 
endmodule
