`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:20:27 11/29/2017 
// Design Name: 
// Module Name:    Ctrler 
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
module Ctrler(
    input [31:0] instr,
	output reg RegWrite = 0,
	output reg RegDst = 0,
	output reg raWrite = 0,
	output reg [1:0] ImmSrc = 0,
	output reg ALUSrc = 0,
	output reg Branch = 0,
	output reg MemWrite = 0,
	output reg MemtoReg = 0,
	output reg [2:0] ALUOp = 0,
	output reg Jump = 0,
	output reg PCtoReg = 0,
	output reg jr = 0
    );

	reg [5:0] OPCode;
	reg [5:0] Funct;
	reg [14:0] signal;
	
	always @* begin
		OPCode = instr[31:26];
		Funct = instr[5:0];
		case (OPCode)
			6'b100011: begin
			//lw
				signal = {1'b1, 1'b0, 1'b0, 2'b00, 1'b1, 1'b0, 1'b0, 1'b1, 3'b010, 1'b0, 1'b0, 1'b0};
				{RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr} = signal;
			end
			6'b101011: begin
			//sw
				signal = {1'b0, 1'b0, 1'b0, 2'b00, 1'b1, 1'b0, 1'b1, 1'b0, 3'b010, 1'b0, 1'b0, 1'b0};
				{RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr} = signal;
			end
			6'b000100: begin
			//beq
				signal = {1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 3'b110, 1'b0, 1'b0, 1'b0};
				{RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr} = signal;
			end
			6'b001000: begin
			//addi
				signal = {1'b1, 1'b0, 1'b0, 2'b00, 1'b1, 1'b0, 1'b0, 1'b0, 3'b010, 1'b0, 1'b0, 1'b0};
				{RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr} = signal;
			end
			6'b000010: begin
			//j
				signal = {1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 3'b011, 1'b1, 1'b0, 1'b0};
				{RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr} = signal;
			end
			6'b001101: begin
			//ori
				signal = {1'b1, 1'b0, 1'b0, 2'b01, 1'b1, 1'b0, 1'b0, 1'b0, 3'b001, 1'b0, 1'b0, 1'b0};
				{RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr} = signal;
			end
			6'b001111: begin
			//lui
				signal = {1'b1, 1'b0, 1'b0, 2'b10, 1'b1, 1'b0, 1'b0, 1'b0, 3'b010, 1'b0, 1'b0, 1'b0};
				{RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr} = signal;
			end
			6'b000011: begin
			//jal
				signal = {1'b1, 1'b0, 1'b1, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 3'b000, 1'b1, 1'b1, 1'b0};
				{RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr} = signal;
			end
			6'b000000: begin
			//jr & R
				if (Funct == 6'b001000) begin
				//jr
					signal = {1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 3'b011, 1'b1, 1'b0, 1'b1};
					{RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, ALUOp, Jump, PCtoReg, jr} = signal;
				end
				else begin
					{RegWrite, RegDst, raWrite, ImmSrc, ALUSrc, Branch, MemWrite, MemtoReg, Jump, PCtoReg, jr} = {1'b1, 1'b1, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
					case (Funct)
						6'b100000: begin
						//add
							ALUOp = 3'b010;
						end
						6'b100010: begin
						//sub
							ALUOp = 3'b110;
						end
						6'b100100: begin
						//and
							ALUOp = 3'b000;
						end
						6'b100101: begin
						//or
							ALUOp = 3'b001;
						end
						6'b101010: begin
						//slt
							ALUOp = 3'b111;
						end
						6'b100001: begin
						//addu
							ALUOp = 3'b010;
						end
						6'b100011: begin
						//subu
							ALUOp = 3'b110;
						end
						default: begin
							ALUOp = 011;
							RegWrite = 0;
						end
					endcase
				end
			end
		endcase
	end
endmodule
