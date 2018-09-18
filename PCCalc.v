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
	input [2:0] Branch,
	input [2:0] Jump,
	input [1:0] AB,
	input [1:0] AZ,
    output reg [31:0] NPC = 0
    );
	
	wire [31:0] BranchAddr;
	wire [31:0] JumpAddr;
	assign BranchAddr = { { 14{instr[15]} }, instr[15:0], 2'b00 };
	assign JumpAddr = { PC8_D[31:28], instr[25:0], 2'b00 };
	
	always @* begin
		case(Branch)
			3'b010: // beq
				NPC <= ( (AB == 2'b01) ? PC8_D+BranchAddr-4 : PC8_D );
			3'b011: //bne
				NPC <= ( (AB != 2'b01) ? PC8_D+BranchAddr-4 : PC8_D );
			3'b110: //blez
				NPC <= ( (AZ != 2'b10) ? PC8_D+BranchAddr-4 : PC8_D );
			3'b100: //bgtz
				NPC <= ( (AZ == 2'b10) ? PC8_D+BranchAddr-4 : PC8_D );
			3'b101: //bltz
				NPC <= ( (AZ == 2'b00) ? PC8_D+BranchAddr-4 : PC8_D );
			3'b111: //bgez
				NPC <= ( (AZ != 2'b00) ? PC8_D+BranchAddr-4 : PC8_D );
			3'b000:
				case(Jump)
					3'b001: // j
						NPC <= JumpAddr; 
					3'b010: // jr
						NPC <= RD1; 
					3'b011: // jalr
						NPC <= RD1; 
					3'b000: // nop
						NPC <= PC8_D;
				endcase
		endcase
	end
endmodule
