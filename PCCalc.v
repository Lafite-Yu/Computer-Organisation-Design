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
    input [31:0] PC8_D,
	input [31:0] RD1,
	input Branch,
	input [1:0] equal,
	input Jump,
	input jr,
    output reg [31:0] NPC = 0
    );
	
	wire [31:0] BranchAddr;
	wire [31:0] JumpAddr;
	assign BranchAddr = { { 14{instr[15]} }, instr[15:0], 2'b00 };
	assign JumpAddr = { PC8_D[31:28], instr[25:0], 2'b00 };
	
	always @* begin
		if (Branch) begin
			if (equal == 2'b01) begin
				NPC <= PC8_D + BranchAddr - 4;
			end
			else begin
				NPC <= PC8_D;
			end
		end
		else if (Jump) begin
			if (jr) begin
				NPC <= RD1;
			end
			else begin
				NPC <= JumpAddr;
			end
		end
		else begin
			NPC <= PC8_D;
		end
	end
endmodule
