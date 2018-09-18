`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:11:42 12/13/2017 
// Design Name: 
// Module Name:    MainDec 
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
module MainDec(
	input [31:0] IR_D,
	output [1:0] EXTSrc, 
	output Branch, Jump, jr, PCSrc,
	output ALU_BSrc,
	output [2:0] ALUOp,
	output MemWrite,
	output RegWrite,
	output [1:0] RFG_WASrc, GRF_WDSrc
    );
	
	wire [5:0] op, funct;
	assign op = IR_D[31:26];
	assign funct = IR_D[5:0];
	reg [15:0] controls;
	
	assign {EXTSrc, Branch, Jump, jr, PCSrc, ALU_BSrc, ALUOp, MemWrite, RegWrite, RFG_WASrc, GRF_WDSrc} = controls;

	always @* begin
		case(op)
			6'b000000:
			//R Type and jr
				begin
					if (funct == 6'b001000)
					//jr
						controls = 16'b00_0_1_1_1_0_000_0_0_00_00;
					else if (IR_D == 0)
						controls = 0;
					else
					//R Type
						controls = 16'b00_0_0_0_0_0_011_0_1_01_01;
				end
			6'b100011:
			//lw
				controls = 16'b00_0_0_0_0_1_010_0_1_00_00;		
			6'b101011:
			//sw
				controls = 16'b00_0_0_0_0_1_010_1_0_00_00;
			6'b001101:
			//ori
				controls = 16'b01_0_0_0_0_1_001_0_1_00_01;
			6'b001111:
			//lui
				controls = 16'b10_0_0_0_0_1_010_0_1_00_01;
			6'b000100:
			//beq
				controls = 16'b00_1_0_0_1_0_000_0_0_00_00;
			6'b000010:
			//j
				controls = 16'b00_0_1_0_1_0_000_0_0_00_00;
			6'b000011:
			//jal
				controls = 16'b00_0_1_0_1_0_000_0_1_10_10;
			default:
				controls = 0;
		endcase
	end
endmodule
