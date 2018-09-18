`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:06 11/29/2017 
// Design Name: 
// Module Name:    PC 
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
module PC_NenR(
    input clk,
	input Nen,
    input reset,
	input [31:0] in,
    output reg [31:0] out = 32'h00003000
    );
	
	always @(posedge clk) begin
		if (reset)
			out <= 32'h00003000;
		else if (!Nen)
			out <= in;
	end
endmodule
