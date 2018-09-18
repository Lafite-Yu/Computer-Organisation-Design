`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:05 11/29/2017 
// Design Name: 
// Module Name:    PCCalc 
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
module PCCalc(
    input [31:0] instr,
    input [31:0] PC,
	input [31:0] RD1,
	input Branch,
	input equal,
	input Jump,
	input jr,
    output reg [31:0] NPC = 0,
    output reg [31:0] PC_plus_4 = 0
    );
	
	wire [31:0] BranchAddr;
	wire [31:0] JumpAddr;
	assign BranchAddr = { { 14{instr[15]} }, instr[15:0], 2'b00 };
	assign JumpAddr = { PC[31:28], instr[25:0], 2'b00 };
	reg cin;
	
	always @* begin
		PC_plus_4 = PC + 4;
		if (Branch) begin
			if (equal) begin
				{cin, NPC} = PC_plus_4 + BranchAddr;
			end
			else begin
				NPC = PC_plus_4;
			end
		end
		else if (Jump) begin
			if (!jr) begin
				NPC = JumpAddr;
			end
			else begin
				NPC = RD1;
			end
		end
		else begin
			NPC = PC_plus_4;
		end
//		if (PCSrc) begin
//			NPC = PC_plus_4 + BranchAddr;
//		end
//		else if (Jump) begin
//			NPC = JumpAddr;
//		end
//		else begin
//			NPC = PC_plus_4;
//		end
	end
endmodule
