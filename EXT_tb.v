`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:39:58 11/29/2017
// Design Name:   EXT
// Module Name:   H:/Computer Organisation/Verilog/code/P4/EXT_tb.v
// Project Name:  P4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: EXT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module EXT_tb;

	// Inputs
	reg [31:0] instr;
	reg [1:0] ImmSrc;

	// Outputs
	wire [31:0] imm;

	// Instantiate the Unit Under Test (UUT)
	EXT uut (
		.instr(instr), 
		.ImmSrc(ImmSrc), 
		.imm(imm)
	);

	initial begin
		// Initialize Inputs
		instr = 0;
		ImmSrc = 0;

		// Wait 100 ns for global reset to finish
		#10;
        instr = 32'h0000f000;
		#10;
		ImmSrc = 1;
		#10;
		ImmSrc = 2;
		// Add stimulus here
	end
      
endmodule

