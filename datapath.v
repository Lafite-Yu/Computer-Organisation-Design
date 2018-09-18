`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:20:47 11/29/2017 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
    input clk,
    input reset,
	input RegWrite,
	input RegDst,
	input raWrite,
	input [1:0] ImmSrc,
	input ALUSrc,
	input Branch,
	input MemWrite,
	input MemtoReg,
	input [2:0] ALUOp,
	input Jump,
	input PCtoReg,
	input jr,
	output [31:0] instr
    );

	reg[31:0] PCValue ;
	wire [31:0] PC;
	wire [4:0] WriteReg;
	wire [31:0] result;
	wire [31:0] RD1;
	wire [31:0] RD2;
	wire [31:0] imm;
	wire [31:0] SrcB;
	wire [31:0] ALUResult;
	wire zero;
	wire [31:0] MemData;
	wire [31:0] PC_plus_4;
	wire [31:0] NPC;
	assign PC = PCValue;
	initial begin
		PCValue = 32'h00003000;
	end
	
	PC PCModule (NPC, clk, reset, PC);
	IM IMModule (PC, instr);
	WriteRegMUX MuxModule0 (instr, RegDst, raWrite, WriteReg);
	GRF GRFModule (instr[25:21], instr[20:16], WriteReg, result, RegWrite, clk, reset, RD1, RD2, PC);
	EXT EXTModule (instr, ImmSrc, imm);
	ALUSrcMUX MUXModule1 (RD2, imm, ALUSrc, SrcB);
	ALU ALUModule (RD1, SrcB, ALUOp, ALUResult, zero);
	DM DMModule (ALUResult, RD2, MemWrite, clk, reset, MemData, PC);
	PCCalc PCCalcModule (instr, PC, RD1, Branch, zero, Jump, jr, NPC, PC_plus_4);
	ResultMUX MUXMudule2 (MemData, ALUResult, PC_plus_4, MemtoReg, PCtoReg, result);
	
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			PCValue <= 32'h00003000;
		end
		else begin
			PCValue <= NPC;
		end
	end
endmodule
