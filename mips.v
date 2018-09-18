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
	
	// datapath
	wire [31:0] IR_D, IR_E, IR_M, IR_W;
	wire XALU_Busy;
	// controller
	wire [1:0] EXTSrc_D;
	wire [2:0] Branch_D;
	wire [2:0] Jump_D;
	wire PCSrc_D;
	wire ALU_BSrc_E;
	wire [3:0] ALUOp_E;
	wire [1:0] MemWrite_M;
	wire [2:0] MemRead_W;
	wire RegWrite_W;
	wire [1:0] GRF_WASrc_W;
	wire [1:0] GRF_WDSrc_W;
	wire [2:0] XALUOp_E;
	wire XALU_Src_E;
	// hazzard
	wire stall, PCNen, FD_Nen, DE_clr;
	assign PCNen = stall, FD_Nen = stall, DE_clr = stall;
	wire [2:0] Forward_RSD, Forward_RTD; 
	wire [2:0] Forward_RSE, Forward_RTE;
	wire Forward_RTM;
	
	Controller Ctrler(clk, reset, IR_D, DE_clr, EXTSrc_D, Branch_D, Jump_D, PCSrc_D, ALU_BSrc_E, ALUOp_E, MemWrite_M, MemRead_W, RegWrite_W, GRF_WASrc_W, GRF_WDSrc_W, XALUOp_E, XALU_Src_E);
	Datapath DP(clk, reset, EXTSrc_D, Branch_D, Jump_D, PCSrc_D, ALU_BSrc_E, ALUOp_E, MemWrite_M, MemRead_W, RegWrite_W, GRF_WASrc_W, GRF_WDSrc_W, XALUOp_E, XALU_Src_E, PCNen, FD_Nen, DE_clr, Forward_RSD, Forward_RTD, Forward_RSE, Forward_RTE, Forward_RTM, IR_D, IR_E, IR_M, IR_W, XALU_Busy);
	Hazard HZ(IR_D, IR_E, IR_M, IR_W, XALU_Busy, XALUOp_E, stall, Forward_RSD, Forward_RTD, Forward_RSE, Forward_RTE, Forward_RTM);
endmodule
