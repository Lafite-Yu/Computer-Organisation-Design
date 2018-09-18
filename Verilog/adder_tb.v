`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:19:59 10/25/2017
// Design Name:   fourBitFullAdder
// Module Name:   H:/Computer Organisation/Verilog/code/p-1/adder_tb.v
// Project Name:  p-1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fourBitFullAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module adder_tb;

	// Inputs
	reg [1:0] A;
	reg [1:0] B;
	reg cin;

	// Outputs
	wire cout;
	wire [1:0] S;

	// Instantiate the Unit Under Test (UUT)
	fourBitFullAdder uut (
		.A(A), 
		.B(B), 
		.cin(cin), 
		.cout(cout), 
		.S(S)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
       A = 3;
		 B = 3;
		 cin = 0;
		// Add stimulus here

	end
      
endmodule

