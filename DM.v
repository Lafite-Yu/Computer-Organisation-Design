`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:15 11/29/2017 
// Design Name: 
// Module Name:    DM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DM(
    input [31:0] A,
    input [31:0] WD,
    input MemWrite,
    input clk,
    input reset,
    output [31:0] RD,
	input [31:0] PC
    );
	
	wire [9:0] addr;
	assign addr = A[11:2];
	integer i;
	reg [31:0] RAM [1023:0];
	initial begin
		for (i = 0; i < 1024; i = i + 1) begin
			RAM[i] = 0;
		end
	end
	
	assign RD = RAM[addr];
	
	always @ (posedge clk) begin
		if (reset) begin
			for (i = 0; i < 1024; i = i + 1)
				RAM[i] <= 0;
		end
		else begin
			if (MemWrite) begin
				RAM[addr] <= WD;
				$display("%d@%h: *%h <= %h", $time, PC, A, WD);
			end
		end
	end
endmodule
