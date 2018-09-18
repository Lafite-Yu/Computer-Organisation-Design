`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:11:54 12/13/2017 
// Design Name: 
// Module Name:    ALUDec 
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
module ALUDec(
	input [31:0] IR_D,
	input [2:0] ALUOp,
	output reg [2:0] ALUCtrl = 0
    );
	
	wire [5:0] funct;
	assign funct = IR_D[5:0];
	
	always @* begin
		if (ALUOp == 3'b011) begin
			case (funct)
				6'b100000://add	
					ALUCtrl = 3'b010;
				6'b100010://sub
					ALUCtrl = 3'b110;
				6'b100100://and
					ALUCtrl = 3'b000;
				6'b100101://or
					ALUCtrl = 3'b001;
				6'b101010://slt
					ALUCtrl = 111;
				6'b100001://addu
					ALUCtrl = 3'b010;
				6'b100011://subu
					ALUCtrl = 3'b110;
				default:
					ALUCtrl = 0;
			endcase
		end
		else
			ALUCtrl = ALUOp;
	end

endmodule
