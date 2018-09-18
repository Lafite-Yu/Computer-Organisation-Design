`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:59:58 10/25/2017
// Design Name:   vote
// Module Name:   D:/Computer Organisation/Verilog/code/p-1/vote_tb.v
// Project Name:  p-1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vote
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vote_tb;

	// Inputs
	reg A;
	reg B;
	reg C;

	// Outputs
	wire Result;
	wire out;

	// Instantiate the Unit Under Test (UUT)
	vote uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.Result(Result), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		C = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		A = 1;
		B = 1;
		C = 1;

	end
      
endmodule

