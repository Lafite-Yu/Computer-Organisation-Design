`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:04:33 11/29/2017
// Design Name:   Ctrler
// Module Name:   H:/Computer Organisation/Verilog/code/P4/Ctrler_tb.v
// Project Name:  P4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Ctrler
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Ctrler_tb;

	// Inputs
	reg [31:0] instr;

	// Outputs
	wire RegWrite;
	wire RegDst;
	wire raWrite;
	wire [1:0] ImmSrc;
	wire ALUSrc;
	wire Branch;
	wire MemWrite;
	wire MemtoReg;
	wire [2:0] ALUOp;
	wire Jump;
	wire PCtoReg;
	wire jr;

	// Instantiate the Unit Under Test (UUT)
	Ctrler uut (
		.instr(instr), 
		.RegWrite(RegWrite), 
		.RegDst(RegDst), 
		.raWrite(raWrite), 
		.ImmSrc(ImmSrc), 
		.ALUSrc(ALUSrc), 
		.Branch(Branch), 
		.MemWrite(MemWrite), 
		.MemtoReg(MemtoReg), 
		.ALUOp(ALUOp), 
		.Jump(Jump), 
		.PCtoReg(PCtoReg),
		.jr(jr)
	);

	initial begin
		// Initialize Inputs
		instr = 32'h0;

		// Wait 100 ns for global reset to finish
		#10;
        instr = 32'h00430820;
		#10;
        instr = 32'h00430822;
		#10;
        instr = 32'h00430824;
		#10;
        instr = 32'h00430825;
		#10;
        instr = 32'h0043082a;
		#10;
        instr = 32'h00430821;
		#10;
        instr = 32'h00430823;
		#10;
        instr = 32'h8c010000;
		#10;
        instr = 32'hac010000;
		#10;
        instr = 32'h10220006;
		#10;
        instr = 32'h2041000a;
		#10;
        instr = 32'h08000c10;
		#10;
        instr = 32'h3441000a;
		#10;
        instr = 32'h3c01000a;
		#10;
        instr = 32'h0c000c10;
		#10;
        instr = 32'h03e00008;
		#10;
        instr = 32'h00000000;
		// Add stimulus here

	end
	integer i = 0;
    always begin
		#10;
		$display("%d: %d %d %d %d %d %d %d %d %d %d %d %d \n", i, RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr);
		i = i + 1;
	end
endmodule

