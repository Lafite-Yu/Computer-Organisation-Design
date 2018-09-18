`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:49:02 10/24/2017
// Design Name:   id_fsm
// Module Name:   H:/Computer Organisation/Verilog/p-1/id_tb.v
// Project Name:  p-1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: id_fsm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module id_tb;

	// Inputs
	reg [7:0] char;
	reg clk;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	id_fsm uut (
		.char(char), 
		.clk(clk), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		char = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		char = "0";
		#10;
		char = "1";
		#10;
		char = "0";
		#10;
		char = "1";
		#10;
		char = "0";
		#10;
		char = "a";
		#10;
		char = "b";
		#10;
		char = "C";
		#10;
		char = "2";
		#10;
		char = "3";
		#10;
		char = "/";
		#10;
		char = "A";
		#10;
		char = "a";
		#10;
		char = "2";
		#10;
		char = "3";
	end
     
	always #5 clk = ~clk;
endmodule

