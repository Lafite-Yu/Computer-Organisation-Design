`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:46:55 10/25/2017 
// Design Name: 
// Module Name:    vote 
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
module vote(
    input A,
    input B,
    input C,
	 output out
    );
	
	assign out = (A&B)|(A&C)|(B&C);
	
endmodule
