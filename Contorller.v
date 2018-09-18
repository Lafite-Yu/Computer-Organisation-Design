`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:20:17 12/13/2017 
// Design Name: 
// Module Name:    Contorller 
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
// IF->D->E->M->W
//////////////////////////////////////////////////////////////////////////////////
module Controller(
	input clk,
	input reset,
    input [31:0] IR_D,
	input DE_clr,
	output [1:0] EXTSrc_D,
	output [2:0] Branch_D, 
	output [2:0] Jump_D,
	output PCSrc_D,
	output ALU_BSrc_E,
	output [3:0] ALUOp_E,
	output [1:0] MemWrite_M,
	output [2:0] MemRead_W,
	output RegWrite_W,
	output [1:0] GRF_WASrc_W,
	output [1:0] GRF_WDSrc_W,
	output [2:0] XALUOp_E,
	output XALU_Src_E
    );
	
	wire ALU_BSrc_D;
	wire [3:0] ALUOp_D;
	wire [1:0] MemWrite_D, MemWrite_E;
	wire [2:0] MemRead_D, MemRead_E, MemRead_M;
	wire RegWrite_D, RegWrite_E, RegWrite_M;
	wire [1:0] GRF_WASrc_D, GRF_WASrc_E, GRF_WASrc_M;
	wire [1:0] GRF_WDSrc_D, GRF_WDSrc_E, GRF_WDSrc_M;
	wire [2:0] XALUOp_D;
	wire XALU_Src_D;

	MainDec MD(IR_D, EXTSrc_D, Branch_D, Jump_D, PCSrc_D, ALU_BSrc_D, ALUOp_D, MemWrite_D, MemRead_D, RegWrite_D, GRF_WASrc_D, GRF_WDSrc_D, XALUOp_D, XALU_Src_D);
	
	//Pipeline Registers
	Flop_RC #(19) DE_CtrlReg(clk, reset, DE_clr, {ALU_BSrc_D, ALUOp_D, MemWrite_D, MemRead_D, RegWrite_D, GRF_WASrc_D, GRF_WDSrc_D, XALUOp_D, XALU_Src_D}, {ALU_BSrc_E, ALUOp_E, MemWrite_E, MemRead_E, RegWrite_E, GRF_WASrc_E, GRF_WDSrc_E, XALUOp_E, XALU_Src_E});
	Flop_R #(10) EM_CtrlReg(clk, reset, {MemWrite_E, MemRead_E, RegWrite_E, GRF_WASrc_E, GRF_WDSrc_E}, {MemWrite_M, MemRead_M, RegWrite_M, GRF_WASrc_M, GRF_WDSrc_M});
	Flop_R #(8) MW_CtrlReg(clk, reset, {MemRead_M, RegWrite_M, GRF_WASrc_M, GRF_WDSrc_M}, {MemRead_W, RegWrite_W, GRF_WASrc_W, GRF_WDSrc_W});
endmodule
