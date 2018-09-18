`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:54:33 12/26/2017 
// Design Name: 
// Module Name:    DM_EXT 
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
module DM__EXT(
	input [31:0] DM_W,
	input [31:0] ALUOut_W,
	input [2:0] MemRead_W,
	output reg [31:0] DMToReg
    );
	wire [7:0] b3, b2, b1, b0;
	assign b3 = DM_W[31:24], b2 = DM_W[23:16], b1 = DM_W[15:8], b0 = DM_W[7:0];
	
	always @* begin
		case(MemRead_W)
			3'b010: // b
				case(ALUOut_W[1:0])
					0:	DMToReg = { {24{b0[7]}}, b0 };
					1:	DMToReg = { {24{b1[7]}}, b1 };
					2:	DMToReg = { {24{b2[7]}}, b2 };
					3:	DMToReg = { {24{b3[7]}}, b3 };
				endcase
			3'b011: // bu
				case(ALUOut_W[1:0])
					0:	DMToReg = { {24{1'b0}}, b0 };
					1:	DMToReg = { {24{1'b0}}, b1 };
					2:	DMToReg = { {24{1'b0}}, b2 };
					3:	DMToReg = { {24{1'b0}}, b3 };
				endcase
			3'b100: // h
				case(ALUOut_W[1])
					0:	DMToReg = { {16{b1[7]}}, {b1, b0} };
					1:	DMToReg = { {16{b3[7]}}, {b3, b2} };
				endcase
			3'b101: // hu
				case(ALUOut_W[1])
					0:	DMToReg = { {16{1'b0}}, {b1, b0} };
					1:	DMToReg = { {16{1'b0}}, {b3, b2} };
				endcase
			3'b110: // w
				DMToReg = { b3, b2, b1, b0 };
			default:
				DMToReg = 0;
		endcase
	end


endmodule
