`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:16:37 11/29/2017
// Design Name:   DM
// Module Name:   H:/Computer Organisation/Verilog/code/P4/DM_tb.v
// Project Name:  P4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DM_tb;

	// Inputs
	reg [31:0] in;
	reg [31:0] WD;
	reg MemWrite;
	reg clk;
	reg reset;
	reg [31:0] PC;

	// Outputs
	wire [31:0] RD;

	// Instantiate the Unit Under Test (UUT)
	DM uut (
		.in(in), 
		.WD(WD), 
		.MemWrite(MemWrite), 
		.clk(clk), 
		.reset(reset), 
		.RD(RD), 
		.PC(PC)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		WD = 0;
		MemWrite = 0;
		clk = 1;
		reset = 0;
		PC = 0;

		// Wait 100 ns for global reset to finish
		#10;
        in = 40;
		WD = 32'hffffffff;
		
		#10;
		MemWrite = 1;
		PC = 32'h0000318;
		
		#10;
		MemWrite = 0;
		
		#20;
		reset = 1;
		// Add stimulus here
	end
	always #5 clk = ~clk;
endmodule

