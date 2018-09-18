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
module WriteRegMUX(
    input [31:0] instr,
    input RegDst,
	input raWrite,
    output reg [4:0] WriteReg = 0
    );
	
	always @* begin
		if (raWrite) begin
			WriteReg = 31;
		end
		else begin
			if (RegDst == 0) begin
				WriteReg = instr[20:16];
			end
			else begin
				WriteReg = instr[15:11];
			end
		end
	end
endmodule

module ALUSrcMUX(
    input [31:0] RD2,
	input [31:0] imm,
    input ALUSrc,
    output reg [31:0] B = 0
    );
	
	always @* begin
		if (ALUSrc == 0) begin
			B  = RD2;
		end
		else begin
			B = imm;
		end
	end
endmodule

module ResultMUX(
    input [31:0] RD,
	input [31:0] ALUResult,
	input [31:0] PC_plus_4,
    input MemtoReg,
	input PCtoReg,
    output reg [31:0] Result = 0
    );
	
	always @* begin
		if (PCtoReg == 0) begin
			if (MemtoReg == 0) begin
				Result = ALUResult;
			end
			else begin
				Result = RD;
			end
		end
		else begin
			Result = PC_plus_4;
		end
	end
endmodule
