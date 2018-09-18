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
    input [2:0] ALUOp,
    output reg [31:0] C = 0,
	output reg zero = 0
    );

	always @* begin
		if (A == B) 
			zero = 1;
		else
			zero = 0;
		case(ALUOp)
			3'b000: begin
				C = A & B;
			end
			
			3'b001: begin
				C = A | B;
			end
			
			3'b010: begin
				C = A + B;
			end
			
			3'b011: begin
				C = 0;
			end
			
			3'b100: begin
				C = A & ~B;
			end
			
			3'b101: begin
				C = A | ~B;
			end
			
			3'b110: begin
				C = A - B;
			end
			
			3'b111: begin
				if (A < B) begin
					C = 1;
				end
				else begin
					C = 0;
				end
			end
		endcase
	end
endmodule
