`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:43 12/13/2017 
// Design Name: 
// Module Name:    ADD4 
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
module ADD4(
    input [31:0] PC,
    output [31:0] PCPlus4
    );
	
	assign PCPlus4 = PC + 4;
	
endmodule

module ADD8(
    input [31:0] PC,
    output [31:0] PCPlus8
    );
	
	assign PCPlus8 = PC + 8;
	
endmodule
