`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:20:47 11/29/2017 
// Design Name: 
// Module Name:    MUX 
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
module PC__MUX(
	input [31:0] ADD4,
	input [31:0] NPC,
	input PCSrc,
	output [31:0] PCNext
	);

	assign PCNext = ( PCSrc == 0 ? ADD4 : NPC);
	
endmodule

module ALU__BMUX(
    input [31:0] RT_E,
	input [31:0] EXT_E,
    input ALU_BSrc,
    output [31:0] B
    );
	
	assign B = (ALU_BSrc == 0 ? RT_E : EXT_E); 

endmodule

module GRF__WAMUX(
    input [31:0] IR_W,
    input [1:0] GRF_WASrc,
    output reg [4:0] GRFaddr = 0
    );
	
	always @* begin
		if (GRF_WASrc == 2'b00)
			GRFaddr = IR_W[20:16];
		else if (GRF_WASrc == 2'b01)
			GRFaddr = IR_W[15:11];
		else if (GRF_WASrc == 2'b10)
			GRFaddr = 5'b11111;
	end
endmodule

module GRF__WDMUX(
    input [31:0] DM_W,
	input [31:0] ALUOut_W,
	input [31:0] PC8_W,
	input [31:0] XALUOut_W,
    input [1:0] GRF_WDSrc,
    output reg [31:0] GRFdata
    );
	
	always @* begin
		if (GRF_WDSrc == 2'b00)
			GRFdata = DM_W;
		else if (GRF_WDSrc == 2'b01)
			GRFdata = ALUOut_W;
		else if (GRF_WDSrc == 2'b10)
			GRFdata = PC8_W;
		else if (GRF_WDSrc == 2'b11)
			GRFdata = XALUOut_W;
	end
endmodule

module XALU__MUX(
	input [31:0] XALU_LO,
	input [31:0] XALU_HI,
	input XALU_Src,
	output [31:0] XALUOut
	);

	assign XALUOut = ( XALU_Src == 0 ? XALU_LO : XALU_HI);
	
endmodule
