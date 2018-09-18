`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:59:24 11/29/2017 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    input WE3,
    input clk,
    input reset,
    output [31:0] RD1,
    output [31:0] RD2,
	input [31:0] PC
    );

	reg [31:0] register[31:0];
	integer i;
	initial begin
		for (i = 0; i < 32; i = i + 1) begin
			register[i] = 0;
		end
	end
				
	assign RD1 = register[A1];
	assign RD2 = register[A2];
			
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			for (i = 0; i < 32; i = i + 1) begin
				register[i] = 0;
			end
		end
		else begin
			if (WE3) begin
				$display("@%h: $%d <= %h", PC, A3, WD3);
				if (A3 != 0) begin
					register[A3] = WD3;
				end
			end
		end
	end				
endmodule
