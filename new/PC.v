`timescale 1ns / 1ps

`include "const.vh"

module PC(
    input wire clk,
    input wire rst,
    input wire [31:0] PCin,
    input wire pause,

    output reg[31:0] PCout
);

always @ (posedge clk or posedge rst) begin
    if(!rst || pause) begin
        PCout = `INIT_32;
    end
    //when reading continue
    else begin
    	PCout = PCin;
    end
end
endmodule
