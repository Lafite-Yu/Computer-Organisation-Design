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
    output reg [1:0] AB = 0,
	output reg [1:0] AZ = 0
    );
	
	always @* begin
		if ($signed(A) > $signed(B)) 
			AB <= 2'b10;
		else if ($signed(A) == $signed(B))
			AB <= 2'b01;
		else
			AB <= 2'b00;
		
		if ($signed(A) > 0) 
			AZ <= 2'b10;
		else if ($signed(A) == 0)
			AZ <= 2'b01;
		else
			AZ <= 2'b00;
	end

endmodule
