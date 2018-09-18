`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:51:50 11/29/2017 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] in,
    output [31:0] instr
    );
	
	wire [9:0] addr;
	assign addr = in[11:2];
	reg [31:0] ROM [1023:0];
	initial begin
		$readmemh ("code.txt", ROM);
	end
	
	assign instr = ROM[addr];
endmodule
