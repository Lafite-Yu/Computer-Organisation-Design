`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:39:18 12/14/2017 
// Design Name: 
// Module Name:    MF_MUX 
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
module MF__RSDMUX(
	input [2:0] sel,
	input [31:0] RD1, PC8_E, ALUOut_M, PC8_M, GRF_WD, XALUOut_M,
	output [31:0] MF_RSD
    );
	
	assign MF_RSD = ( sel == 3'b000 ? RD1 : 
					sel == 3'b001 ? PC8_E : 
					sel == 3'b010 ? ALUOut_M : 
					sel == 3'b011 ? PC8_M : 
					sel == 3'b100 ? GRF_WD :
					sel == 3'b101 ? XALUOut_M : 0 );
endmodule

module MF__RTDMUX(
	input [2:0] sel,
	input [31:0] RD2, PC8_E, ALUOut_M, PC8_M, GRF_WD, XALUOut_M,
	output [31:0] MF_RTD
    );
	
	assign MF_RTD = ( sel == 3'b000 ? RD2 : 
					sel == 3'b001 ? PC8_E : 
					sel == 3'b010 ? ALUOut_M : 
					sel == 3'b011 ? PC8_M : 
					sel == 3'b100 ? GRF_WD :
					sel == 3'b101 ? XALUOut_M : 0 );
endmodule

module MF__RSEMUX(
	input [2:0] sel,
	input [31:0] RS_E, ALUOut_M, PC8_M, GRF_WD, XALUOut_M,
	output [31:0] MF_RSE
    );
	
	assign MF_RSE = ( sel == 3'b000 ? RS_E : 
					sel == 3'b001 ? ALUOut_M : 
					sel == 3'b010 ?  PC8_M : 
					sel == 3'b011 ? GRF_WD : 
					sel == 3'b100 ? XALUOut_M : 0);
endmodule

module MF__RTEMUX(
	input [2:0] sel,
	input [31:0] RT_E, ALUOut_M, PC8_M, GRF_WD, XALUOut_M, 
	output [31:0] MF_RTE
    );
	
	assign MF_RTE = (sel == 3'b000 ? RT_E : 
					sel == 3'b001 ? ALUOut_M : 
					sel == 3'b010 ?  PC8_M : 
					sel == 3'b011 ? GRF_WD : 
					sel == 3'b100 ? XALUOut_M : 0 );
endmodule

module MF__RTMMUX(
	input sel,
	input [31:0] RT_M, GRF_WD,
	output [31:0] MF_RTM
);

	assign MF_RTM = ( sel == 1'b0 ? RT_M :
					sel == 1'b1 ? GRF_WD : 0 );
endmodule
