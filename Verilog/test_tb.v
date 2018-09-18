`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:50:47 11/04/2017
// Design Name:   test
// Module Name:   D:/Computer Organisation/Verilog/code/p-1/test_tb.v
// Project Name:  p-1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_tb;

	// Inputs
	reg Q3;
	reg Q2;
	reg Q1;
	reg C;
	reg Clk;

	// Instantiate the Unit Under Test (UUT)
	test uut (
		.Q3(Q3), 
		.Q2(Q2), 
		.Q1(Q1), 
		.C(C),
		.Clk(Clk)
	);

	initial begin
		// Initialize Inputs
		Q3 = 0;
		Q2 = 0;
		Q1 = 0;
		C = 0;
		Clk = 0;

		// Wait 100 ns for global reset to finish
		#105;
		Q1 = 1;
		C = 1;
		
		#10;
		Q2 = 1;
		
		#10;
		Q3 = 1;
		
		#10;
		Q1 = 0;
		
		#10;
		Q1 = 0;
		Q2 = 0;
		Q3 = 0;
		C = 0;
		
		#10;
		Q1 = 1;
		C = 1;		
       
		// Add stimulus here

	end
      
	always #5 Clk = ~Clk;
endmodule

