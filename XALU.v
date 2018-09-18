`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:03:44 12/24/2017 
// Design Name: 
// Module Name:    XALU 
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
module XALU(
	input clk,
	input reset,
    input [31:0] A,
    input [31:0] B,
	input [2:0] XALU_Op,
    output reg busy,
    output reg [31:0] HI,
    output reg [31:0] LO
    );

	wire mult, multu, div, divu, HIWrite, LOWrite, read;
	assign read = (XALU_Op == 3'b001);
	assign HIWrite = (XALU_Op == 3'b011);
	assign LOWrite = (XALU_Op == 3'b010);
	assign mult = (XALU_Op == 3'b110);
	assign multu = (XALU_Op == 3'b111);
	assign div = (XALU_Op == 3'b100);
	assign divu = (XALU_Op == 3'b101);

	reg [3:0] CycleCounter;
	reg [31:0] HIResult, LOResult;
	
	always @(posedge clk) begin
		if (reset) begin
			CycleCounter <= 0;
			busy <= 0;
			HI <= 0;
			LO <= 0;
			HIResult <= 0;
			LOResult <= 0;
		end
		else begin 
			if ( mult | multu | div | divu ) begin
				if (mult) begin
					busy <= 1;
					{HIResult, LOResult} <= A*B;
					CycleCounter <= 4'b0101;
				end
				else if (multu) begin
					busy <= 1;
					{HIResult, LOResult} <= {1'b0, A}*{1'b0, B} ;
					CycleCounter <= 4'b0101;
				end
//				else if (div && B != 0) begin
//					busy <= 1;
//					LOResult <= A/B;
//					HIResult <= A%B;
//					CycleCounter <= 4'b1010;
//				end
//				else if (divu && B != 0) begin
//					busy <= 1;
//					LOResult <= {1'b0, A}/{1'b0, B};
//					HIResult <= {1'b0, A}%{1'b0, B};
//					CycleCounter <= 4'b1010;
//				end
			end
			else if (busy) begin
				CycleCounter <= CycleCounter - 1;
				if (CycleCounter == 1) begin
					HI <= HIResult;
					LO <= LOResult;
					busy <= 0;
				end
			end
			else if (HIWrite) begin
				HI <= A;
//				HIResult <= A;
			end
			else if (LOWrite) begin
				LO <= A;
//				LOResult <= A;
			end
		end
	end
	
endmodule
