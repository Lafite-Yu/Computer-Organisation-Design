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

    wire [31:0] IR_D, IR_E, IR_M, IR_W;
	wire Branch_D, Jump_D, jr_D, PCSrc_D;
	wire [1:0] EXTSrc_D;
	wire ALU_BSrc_E;
	wire [2:0] ALUCtrl_E;
	wire MemWrite_M;
	wire [1:0] GRF_WDSrc_E, GRF_WDSrc_M, GRF_WDSrc_W;
	wire [1:0] GRF_WASrc_W;
	wire RegWrite_E, RegWrite_M, RegWrite_W;
	
	wire stall, PCNen, FD_Nen, DE_clr;
	assign PCNen = stall, FD_Nen = stall, DE_clr = stall;
	wire [2:0] Forward_RSD, Forward_RTD; 
	wire [1:0] Forward_RSE, Forward_RTE;
	wire Forward_RTM;
	
	Controller Ctrler(clk, reset, IR_D, DE_clr, Branch_D, Jump_D, jr_D, PCSrc_D, EXTSrc_D, ALU_BSrc_E, ALUCtrl_E, MemWrite_M, GRF_WDSrc_E, GRF_WDSrc_M, GRF_WDSrc_W, GRF_WASrc_W, RegWrite_E, RegWrite_M, RegWrite_W);
	Datapath DP(clk, reset, Branch_D, Jump_D, jr_D, PCSrc_D, EXTSrc_D, ALU_BSrc_E, ALUCtrl_E, MemWrite_M, GRF_WDSrc_E, GRF_WDSrc_M, GRF_WDSrc_W, GRF_WASrc_W, RegWrite_E, RegWrite_M, RegWrite_W, PCNen, FD_Nen, DE_clr, Forward_RSD, Forward_RTD, Forward_RSE, Forward_RTE, Forward_RTM, IR_D, IR_E, IR_M, IR_W);
	Hazard HZ(IR_D, IR_E, IR_M, IR_W, stall, Forward_RSD, Forward_RTD, Forward_RSE, Forward_RTE, Forward_RTM);
endmodule
