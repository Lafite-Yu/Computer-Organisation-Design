`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:26:45 11/29/2017 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUOp,
	input [31:0] IR,
    output reg [31:0] C = 0,
	output reg zero = 0
    );
	
	always @* begin
		if (A == B) 
			zero = 1;
		else
			zero = 0;
		case(ALUOp)
			4'b0000: // NOP
				C = 0;
			4'b0001: // ADD
				C = A + B;
			4'b0010: // SUB
				C = A - B;
			4'b0011: // SLL
				C = B << IR[10:6];
			4'b0100: // SLLV
				C = B << A[4:0];
			4'b0101: //SRL
				C = B >> IR[10:6];
			4'b0110: //SRLV
				C = B >> A[4:0];
			4'b0111: // SRA
				C = $signed(B) >>> IR[10:6];
			4'b1000: // SRAV
				C = $signed(B) >>> A[4:0];
			4'b1001: // AND
				C = A & B;
			4'b1010: // OR
				C = A | B;
			4'b1011: // XOR
				C = A ^ B;
			4'b1100: // NOR
				C = ~( A | B );
			4'b1101: // SLT
				C = ( $signed(A) < $signed(B) );
			4'b1110: // SLTU
				C = ( A < B );
			4'b1111: // NOP
				C = 0;
		endcase
	end
endmodule
