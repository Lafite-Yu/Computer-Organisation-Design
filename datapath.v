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
module Datapath(
    input clk,
    input reset,
	// from controller
	input [1:0] EXTSrc_D,
	input [2:0] Branch_D, 
	input [2:0] Jump_D,
	input PCSrc_D,
	input ALU_BSrc_E,
	input [3:0] ALUOp_E,
	input [1:0] MemWrite_M,
	input [2:0] MemRead_W,
	input RegWrite_W,
	input [1:0] GRF_WASrc_W,
	input [1:0] GRF_WDSrc_W,
	input [2:0] XALUOp_E,
	input XALU_Src_E,
	// from hazard
	input PCNen, FD_Nen, DE_clr,
	input [2:0] Forward_RSD, Forward_RTD, 
	input [2:0] Forward_RSE, Forward_RTE, 
	input Forward_RTM,
	output [31:0] IR_D, IR_E, IR_M, IR_W,
	output XALU_Busy
    );

	// IF Modules Wires 
	wire [31:0] PC, PCNext, PC4, PC8;
	wire [31:0] IR;
	// F/D Reg Wires
	wire FD_clr;
	wire [31:0] PC8_D;
	// D Modules Wires
	wire [4:0] GRF_WA;
	wire [31:0] GRF_WD, RD1, RD2;
	wire [31:0] MF_RSD, MF_RTD, MF_RSE, MF_RTE, MF_RTM;	
	wire [1:0] CMP_AB, CMP_AZ;
	wire [31:0] imm;
	wire [31:0] NPC;
	// D/E Reg Wires
	wire [31:0] PC8_E, RS_E, RT_E, EXT_E;
	// E Modules Wires
	wire [31:0] ALU_B, ALUOut;
	wire ALUEqual;
	wire [31:0] XALU_HI, XALU_LO;
	// E/M Reg Wires
	wire [31:0] XALUOut, XALUOut_M;
	wire [31:0] PC8_M, ALUOut_M, RT_M;
	// M Modules Wires
	wire [31:0] DM_Data;
	// M/W Reg Wires
	wire [31:0] PC8_W, ALUOut_W, XALUOut_W, DM_W;
	// W Modules Wires
	wire [31:0] DMToReg;
	
	
	// IF Modules
	PC_NenR PCReg(clk, PCNen, reset, PCNext, PC);
	ADD4 PCAdd4(PC, PC4);
	ADD8 PCAdd8(PC, PC8);
	IM IMem(PC, IR);
	// F/D Reg
	Flop_NenRC #(64) FD_Reg (clk, FD_Nen, reset, FD_clr, {IR, PC8}, {IR_D, PC8_D});

	// D Modules
	wire [31:0] PC_W;
	assign PC_W = PC8_W - 8;
	GRF_EnRC GRF(RegWrite_W, reset, clk, IR_D[25:21], IR_D[20:16], GRF_WA, GRF_WD, RD1, RD2, PC_W);
	MF__RSDMUX MF_RSDMUX(Forward_RSD, RD1, PC8_E, ALUOut_M, PC8_M, GRF_WD, XALUOut_M, MF_RSD);
	MF__RTDMUX MF_RTDMUX(Forward_RTD, RD2, PC8_E, ALUOut_M, PC8_M, GRF_WD, XALUOut_M, MF_RTD);
	CMP Cmp(MF_RSD, MF_RTD, CMP_AB, CMP_AZ);
	EXT Ext(IR_D, EXTSrc_D, imm);
	PCCalc PCcalc(IR_D, PC8_D, MF_RSD, Branch_D, Jump_D,CMP_AB, CMP_AZ, NPC);
	PC__MUX PC_MUX(PC4, NPC, PCSrc_D, PCNext);
	// D/E Reg
	Flop_RC #(160) DE_Reg(clk, reset, DE_clr, {IR_D, PC8_D, RD1, RD2, imm}, {IR_E, PC8_E, RS_E, RT_E, EXT_E});

	// E Modules
	MF__RSEMUX MF_RSEMUX(Forward_RSE, RS_E, ALUOut_M, PC8_M, GRF_WD, XALUOut_M, MF_RSE);
	MF__RTEMUX MF_RTEMUX(Forward_RTE, RT_E, ALUOut_M, PC8_M, GRF_WD, XALUOut_M, MF_RTE);
	ALU ALUModule(MF_RSE, ALU_B, ALUOp_E, IR_E, ALUOut, ALUEqual);
	ALU__BMUX ALU_BMUX(MF_RTE, EXT_E, ALU_BSrc_E, ALU_B);
	XALU XALUModule(clk, reset, MF_RSE, MF_RTE, XALUOp_E, XALU_Busy, XALU_HI, XALU_LO);
	// E/M Reg
	XALU__MUX XALU_MUX(XALU_LO, XALU_HI, XALU_Src_E, XALUOut);
	Flop_R #(160) EM_Reg(clk, reset, {IR_E, PC8_E, ALUOut, XALUOut, MF_RTE}, {IR_M, PC8_M, ALUOut_M, XALUOut_M, RT_M}); 
	
	// M Modules
	wire [31:0] PC_M;
	assign PC_M = PC8_M - 8;
	MF__RTMMUX MF_RTMMUX(Forward_RTM, RT_M, GRF_WD, MF_RTM);
	DM DMem(clk, reset, ALUOut_M, MF_RTM, MemWrite_M, PC_M, DM_Data);
	// M/W Reg
	Flop_R #(160) MW_Reg(clk, reset, {IR_M, PC8_M, ALUOut_M, XALUOut_M, DM_Data}, {IR_W, PC8_W, ALUOut_W, XALUOut_W, DM_W});

	// W Modules
	DM__EXT DM_EXT(DM_W, ALUOut_W, MemRead_W, DMToReg);
	GRF__WAMUX GRF_WAMUX(IR_W, GRF_WASrc_W, GRF_WA);
	GRF__WDMUX GRF_WDMUX(DMToReg, ALUOut_W, PC8_W, XALUOut_W, GRF_WDSrc_W, GRF_WD);
	
	assign FD_clr = 0;

endmodule










