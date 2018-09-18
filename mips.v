`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:18:48 11/29/2017 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

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
	wire [31:0] instr;
	Ctrler CtrlerModule(instr, RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr);
	datapath DataPathModule(clk, reset, RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr, instr);

endmodule
