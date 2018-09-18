`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:56:45 11/07/2017 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] C
    );
	 
	 reg signed [31:0] sA;
	 
	 always @* begin
	 sA = $signed(A);
		case (ALUOp)
			3'b000: begin
				C = A + B;
			end
			
			3'b001: begin
				C = A - B;
			end
			
			3'b010: begin
				C = A & B;
			end
			
			3'b011: begin
				C = A | B;
			end
			
			3'b100: begin
				C = A >> B;
			end
			
			3'b101: begin
				C = sA >>> B;
			end
		endcase
	end
endmodule
