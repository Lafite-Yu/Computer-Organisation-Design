`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:01:37 11/29/2017
// Design Name:   GRF
// Module Name:   H:/Computer Organisation/Verilog/code/P4/GRF_tb.v
// Project Name:  P4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: GRF
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module GRF_tb;

	// Inputs
	reg [4:0] A1;
	reg [4:0] A2;
	reg [4:0] A3;
	reg [31:0] WD3;
	reg WE3;
	reg clk;
	reg reset;

	// Outputs
	wire [31:0] RD1;
	wire [31:0] RD2;

	// Instantiate the Unit Under Test (UUT)
	GRF uut (
		.A1(A1), 
		.A2(A2), 
		.A3(A3), 
		.WD3(WD3), 
		.WE3(WE3), 
		.clk(clk), 
		.reset(reset), 
		.RD1(RD1), 
		.RD2(RD2)
	);

	initial begin
		// Initialize Inputs
		A1 = 0;
		A2 = 0;
		A3 = 0;
		WD3 = 0;
		WE3 = 0;
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#10;
		WE3 = 1;
		A3 = 4;
		WD3 = 1;
		A1 = 4;
        
		// Add stimulus here
	end
      
	  always #5 clk = ~clk;
endmodule

