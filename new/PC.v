`timescale 1ns / 1ps

`include "const.vh"

module PC(
    input wire clk,
    input wire rst,
    input wire [31:0] PCin,
    input wire pause,

    output wire[31:0] PCout
);

reg [31:0] PC;

always @ (posedge clk) begin
    if(!rst) begin
        PC = `INIT_32;
    end
    //when reading continue
    else if(!pause)begin
        PC = PCin;
    end
end

assign PCout = PC ;
endmodule
