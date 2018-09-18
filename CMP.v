`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:23 12/13/2017 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] A,
    input [31:0] B,
    output reg [1:0] result = 0
    );
	
	always @* begin
		if (A > B) 
			result <= 2'b10;
		else if (A == B)
			result <= 2'b01;
		else
			result <= 2'b00;
	end

endmodule
