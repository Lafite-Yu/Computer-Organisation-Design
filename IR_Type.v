`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:46:21 12/24/2017 
// Design Name: 
// Module Name:    IR_Type 
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
module IR_Type_Judger(
	input reset,
    input [31:0] IR,
    output reg [3:0] Type
    );

	`define op IR[31:26]
	`define funct IR[5:0]
	`define rt IR[20:16]

	`define Nop 4'd0
	`define Load 4'd1
	`define Store 4'd2
	`define Cal_R 4'd3
	`define XALU_R 4'd4
	`define XALU_W 4'd5
	`define Cal_I 4'd6
	`define BCB 4'd7
	`define BCZ 4'd8
	`define Jump 4'd9
	`define Jr 4'd10
	`define Jal 4'd11
	`define Jalr 4'd12
	`define Unknown 4'b1111
	
	always @* begin
		if (reset)
			Type = 0;
		case(`op)
			// Load
			6'b100000: Type = `Load; // lb
			6'b100100: Type = `Load; // lbu
			6'b100001: Type = `Load; // lh
			6'b100101: Type = `Load; // lhu
			6'b100011: Type = `Load; // lw
			// Store
			6'b101000: Type = `Store; // sb
			6'b101001: Type = `Store; // sh
			6'b101011: Type = `Store; // sw
			// R Type
			6'b000000:
				case(`funct)
					// Cal_R
					6'b100000: Type = `Cal_R; // add
					6'b100001: Type = `Cal_R; // addu
					6'b100010: Type = `Cal_R; // sub
					6'b100011: Type = `Cal_R; // subu
					6'b000000: Type = ( IR == 0 ? `Nop : `Cal_R ); // sll
					6'b000100: Type = `Cal_R; // sllv
					6'b000010: Type = `Cal_R; // srl
					6'b000110: Type = `Cal_R; // srlv
					6'b000011: Type = `Cal_R; // sra
					6'b000111: Type = `Cal_R; // srav
					6'b100100: Type = `Cal_R; // and
					6'b100101: Type = `Cal_R; // or
					6'b100110: Type = `Cal_R; // xor
					6'b100111: Type = `Cal_R; // nor
					6'b101010: Type = `Cal_R; // slt
					6'b101011: Type = `Cal_R; // sltu
					// Cal_XALU
					6'b010010: Type = `XALU_R; // mflo
					6'b010000: Type = `XALU_R; // mfhi
					6'b010011: Type = `XALU_W; // mtlo
					6'b010001: Type = `XALU_W; // mthi
					6'b011000: Type = `XALU_W; // mult
					6'b011001: Type = `XALU_W; // multu
					6'b011010: Type = `XALU_W; // div
					6'b011011: Type = `XALU_W; // divu
					// Jump
					6'b001001: Type = `Jalr; // jalr
					6'b001000: Type = `Jr; // jr
				endcase
			// Cal_I
			6'b001111: Type = `Cal_I; //lui
			6'b001000: Type = `Cal_I; //addi
			6'b001001: Type = `Cal_I; //addiu
			6'b001100: Type = `Cal_I; //andi
			6'b001101: Type = `Cal_I; //ori
			6'b001110: Type = `Cal_I; //xori
			6'b001010: Type = `Cal_I; //slti
			6'b001011: Type = `Cal_I; //sltiu
			// Branch
			6'b000100: Type = `BCB; //beq
			6'b000101: Type = `BCB; //bne
			6'b000110: Type = `BCZ; //blez
			6'b000111: Type = `BCZ; //bgtz
			6'b000001: 
				case(`rt)
					5'b00000: Type = `BCZ; //bltz
					5'b00001: Type = `BCZ; //bgez
				endcase
			// Jump
			6'b000010: Type = `Jump; //j
			6'b000011: Type = `Jal; //jal
			default: Type = `Nop;
		endcase
	end
	
	

endmodule
