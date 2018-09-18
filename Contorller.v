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
	output Branch_D, Jump_D, jr_D, PCSrc_D,
	output [1:0] EXTSrc_D,
	output ALU_BSrc_E,
	output [2:0] ALUCtrl_E,
	output MemWrite_M,
	output [1:0] GRF_WDSrc_E, GRF_WDSrc_M, GRF_WDSrc_W,
	output [1:0] GRF_WASrc_W,
	output RegWrite_E, RegWrite_M, RegWrite_W
    );
	
	wire [2:0] ALUOp;
	wire ALU_BSrc_D, MemWrite_D, RegWrite_D;
	wire [1:0] GRF_WDSrc_D, GRF_WASrc_D;
	wire [2:0] ALUCtrl_D;
	wire MemWrite_E;
	wire [1:0] GRF_WASrc_E, GRF_WASrc_M;
	
	MainDec MD(IR_D, EXTSrc_D, Branch_D, Jump_D, jr_D, PCSrc_D, ALU_BSrc_D, ALUOp, MemWrite_D, RegWrite_D, GRF_WASrc_D, GRF_WDSrc_D);
	ALUDec AD(IR_D, ALUOp, ALUCtrl_D);
	
	//Pipeline Registers
	Flop_RC #(10) DE_CtrlReg(clk, reset, DE_clr, {ALU_BSrc_D, ALUCtrl_D, MemWrite_D, RegWrite_D, GRF_WASrc_D, GRF_WDSrc_D}, {ALU_BSrc_E, ALUCtrl_E, MemWrite_E, RegWrite_E, GRF_WASrc_E, GRF_WDSrc_E});
	Flop_R #(6) EM_CtrlReg(clk, reset, {MemWrite_E, RegWrite_E, GRF_WASrc_E, GRF_WDSrc_E}, {MemWrite_M, RegWrite_M, GRF_WASrc_M, GRF_WDSrc_M});
	Flop_R #(5) MW_CtrlReg(clk, reset, {RegWrite_M, GRF_WASrc_M, GRF_WDSrc_M}, {RegWrite_W, GRF_WASrc_W, GRF_WDSrc_W});
endmodule
