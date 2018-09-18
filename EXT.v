`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:42 11/29/2017 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [31:0] instr,
    input [1:0] ImmSrc,
    output reg [31:0] imm = 0
    );
	
	wire [15:0] n;
	assign n = instr[15:0];
	
	always @* begin
		case (ImmSrc)
			2'b00: begin
				imm = {{16{n[15]}}, n};
			end
			2'b01: begin
				imm = {16'b0, n};
			end
			2'b10: begin
				imm = {n, 16'b0};
			end
		endcase
	end
endmodule
