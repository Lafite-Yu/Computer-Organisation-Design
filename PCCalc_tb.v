`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:06:12 11/29/2017
// Design Name:   PCCalc
// Module Name:   H:/Computer Organisation/Verilog/code/P4/PCCalc_tb.v
// Project Name:  P4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PCCalc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PCCalc_tb;

	// Inputs
	reg [31:0] instr;
	reg [31:0] PC;
	reg PCSrc;
	reg Jump;

	// Outputs
	wire [31:0] NPC;
	wire [31:0] PC_plus_4;

	// Instantiate the Unit Under Test (UUT)
	PCCalc uut (
		.instr(instr), 
		.PC(PC), 
		.PCSrc(PCSrc), 
		.Jump(Jump), 
		.NPC(NPC), 
		.PC_plus_4(PC_plus_4)
	);

	initial begin
		// Initialize Inputs
		instr = 0;
		PC = 32'h00003000;
		PCSrc = 0;
		Jump = 0;

		// Wait 100 ns for global reset to finish
		#10;
		instr = 32'h10220002;
		
		#10;
		PCSrc = 1;
		
		#10;
		PCSrc = 0;
		Jump = 1;
		instr = 32'h08000c04;
		// Add stimulus here

	end
      
endmodule

