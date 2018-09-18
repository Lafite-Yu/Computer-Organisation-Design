`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:46 12/14/2017 
// Design Name: 
// Module Name:    Hazard 
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
module Hazard(
	input [31:0] IR_D, IR_E, IR_M, IR_W,
	output stall,
	output reg [2:0] Forward_RSD, Forward_RTD = 0, 
	output reg [1:0] Forward_RSE, Forward_RTE = 0, 
	output reg Forward_RTM = 0
    );

	wire [5:0] Op_D, Op_E, Op_M, Op_W;
	wire [5:0] Funct_D, Funct_E, Funct_M, Funct_W;
	assign Op_D = IR_D[31:26];
	assign Funct_D = IR_D[5:0];
	assign Op_E = IR_E[31:26];
	assign Funct_E = IR_E[5:0];
	assign Op_M = IR_M[31:26];
	assign Funct_M = IR_M[5:0];
	assign Op_W = IR_W[31:26];
	assign Funct_W = IR_W[5:0];
	`define rs 25:21
	`define rt 20:16
	`define rd 15:11
	
	// Stall
	wire stall_b, stall_calr, stall_cali, stall_ld, stall_st, stall_jr;
	assign stall_b = (Op_D == 6'b000100) &
					 ( ( (Op_E == 6'b000000 && Funct_E != 6'b000000 && Funct_E != 6'b001000) & ( (IR_D[`rs] == IR_E[`rd]) | (IR_D[`rt] == IR_E[`rd]) ) ) |
					( (Op_E == 6'b001101 | Op_E == 6'b001111)  & ( (IR_D[`rs] == IR_E[`rt]) | (IR_D[`rt] == IR_E[`rt]) ) ) |
					( (Op_E == 6'b100011) & ( (IR_D[`rs] == IR_E[`rt]) | (IR_D[`rt] == IR_E[`rt]) ) ) |
					( (Op_M == 6'b100011) & ( (IR_D[`rs] == IR_M[`rt]) | (IR_D[`rt] == IR_M[`rt]) ) ) );
	assign stall_calr = (Op_D == 6'b000000 && Funct_D != 6'b000000 && Funct_D != 6'b001000) &
						( (Op_E == 6'b100011) & ( (IR_D[`rs] == IR_E[`rt]) | (IR_D[`rt] == IR_E[`rt]) ) );
	assign stall_cali = (Op_D == 6'b001101 | Op_D == 6'b001111) &
						( (Op_E == 6'b100011) & (IR_D[`rs] == IR_E[`rt]) );
	assign stall_ld = (Op_D == 6'b100011) & 
						( (Op_E == 6'b100011) & (IR_D[`rs] == IR_E[`rt]) );
	assign stall_st = (Op_D == 6'b101011) &
						( (Op_E == 6'b100011) & (IR_D[`rs] == IR_E[`rt]) );
	assign stall_jr = (Op_D == 6'b000000 && Funct_D == 6'b001000) &
					 ( ( (Op_E == 6'b000000 && Funct_E != 6'b000000 && Funct_E != 6'b001000) & (IR_D[`rs] == IR_E[`rd]) ) |
					( (Op_E == 6'b001101 | Op_E == 6'b001111)  & (IR_D[`rs] == IR_E[`rt]) ) |
					( (Op_E == 6'b100011) & (IR_D[`rs] == IR_E[`rt]) ) |
					( (Op_M == 6'b100011) & (IR_D[`rs] == IR_M[`rt]) ) );
	assign stall = stall_b | stall_calr | stall_cali | stall_ld | stall_st | stall_jr;
	
	// Forward
	always @* begin
		Forward_RSD = 0;
		Forward_RTD = 0;
		Forward_RSE = 0;
		Forward_RTE = 0;
		Forward_RTM = 0;
		// IR_D
		if (Op_D == 6'b000100 || (Op_D == 6'b000000 && Funct_D == 6'b001000)) begin
			if (IR_D[`rs] != 0)
				if (Op_E == 6'b000011 && IR_D[`rs] == 5'b11111)
					Forward_RSD = 1;
				else if ( (Op_M == 6'b000000 && Funct_M != 6'b000000 && Funct_M != 6'b001000 && IR_D[`rs] == IR_M[`rd]) || ((Op_M == 6'b001101 || Op_M == 6'b001111) && IR_D[`rs] == IR_M[`rt]) )
					Forward_RSD = 2;
				else if (Op_M == 6'b000011 && IR_D[`rs] == 5'b11111)
					Forward_RSD = 3;
				else if ((Op_W == 6'b000000 && Funct_W != 6'b000000 && Funct_W != 6'b001000 && IR_D[`rs] == IR_W[`rd]) || ( (Op_W == 6'b001101 || Op_W == 6'b001111) && IR_D[`rs] == IR_W[`rt] ) || (Op_W == 6'b100011 && IR_D[`rs] == IR_W[`rt]) || (Op_W == 6'b000011 && IR_D[`rs] == 5'b11111) )
					Forward_RSD = 4;
				else
					Forward_RSD = 0;
			if (Op_D == 6'b000100 && IR_D[`rt] != 0)
				if (Op_E == 6'b000011 && IR_D[`rt] == 5'b11111)
					Forward_RTD = 1;
				else if ( (Op_M == 6'b000000 && Funct_M != 6'b000000 && Funct_M != 6'b001000 && IR_D[`rt] == IR_M[`rd]) || ((Op_M == 6'b001101 || Op_M == 6'b001111) && IR_D[`rt] == IR_M[`rt]) )
					Forward_RTD = 2;
				else if (Op_M == 6'b000011 && IR_D[`rt] == 5'b11111)
					Forward_RTD = 3;
				else if ((Op_W == 6'b000000 && Funct_W != 6'b000000 && Funct_W != 6'b001000 && IR_D[`rt] == IR_W[`rd]) || ( (Op_W == 6'b001101 || Op_W == 6'b001111) && IR_D[`rt] == IR_W[`rt] ) || (Op_W == 6'b100011 && IR_D[`rt] == IR_W[`rt]) || (Op_W == 6'b000011 && IR_D[`rt] == 5'b11111) )
					Forward_RTD = 4;
				else
					Forward_RTD = 0;	
		end
		// IR_E
		if ( Op_E == 6'b000000 || (Op_E == 6'b001101 || Op_E == 6'b001111) || Op_E == 6'b100011 || Op_E == 6'b101011 ) begin
			if (IR_E[`rs] != 0)
				if ( (Op_M == 6'b000000 && Funct_M != 6'b000000 && Funct_M != 6'b001000 && IR_E[`rs] == IR_M[`rd]) || ((Op_M == 6'b001101 || Op_M == 6'b001111) && IR_E[`rs] == IR_M[`rt]) )
					Forward_RSE = 1;
				else if (Op_M == 6'b000011 && IR_E[`rs] == 5'b11111)
					Forward_RSE = 2;
				else if ((Op_W == 6'b000000 && Funct_W != 6'b000000 && Funct_W != 6'b001000 && IR_E[`rs] == IR_W[`rd]) || ( (Op_W == 6'b001101 || Op_W == 6'b001111) && IR_E[`rs] == IR_W[`rt] ) || (Op_W == 6'b100011 && IR_E[`rs] == IR_W[`rt]) || (Op_W == 6'b000011 && IR_E[`rs] == 5'b11111) )
					Forward_RSE = 3;
				else
					Forward_RSE = 0;
			if ( (Op_E == 6'b000000 || Op_E == 6'b101011 ) && IR_E[`rt] != 0 )
				if ( (Op_M == 6'b000000 && Funct_M != 6'b000000 && Funct_M != 6'b001000 && IR_E[`rt] == IR_M[`rd]) || ((Op_M == 6'b001101 || Op_M == 6'b001111) && IR_E[`rt] == IR_M[`rt]) )
					Forward_RTE = 1;
				else if (Op_M == 6'b000011 && IR_E[`rt] == 5'b11111)
					Forward_RTE = 2;
				else if ((Op_W == 6'b000000 && Funct_W != 6'b000000 && Funct_W != 6'b001000 && IR_E[`rt] == IR_W[`rd]) || ( (Op_W == 6'b001101 || Op_W == 6'b001111) && IR_E[`rt] == IR_W[`rt] ) || (Op_W == 6'b100011 && IR_E[`rt] == IR_W[`rt]) || (Op_W == 6'b000011 && IR_E[`rt] == 5'b11111) )
					Forward_RTE = 3;
				else
					Forward_RTE = 0;	
		end
		// IR_M
		if ( Op_M == 6'b101011 && IR_M[`rt] != 0)
			if ((Op_W == 6'b000000 && Funct_W != 6'b000000 && Funct_W != 6'b001000 && IR_M[`rt] == IR_W[`rd]) || ( (Op_W == 6'b001101 || Op_W == 6'b001111) && IR_M[`rt] == IR_W[`rt] ) || (Op_W == 6'b100011 && IR_M[`rt] == IR_W[`rt]) || (Op_W == 6'b000011 && IR_M[`rt] == 5'b11111) )
				Forward_RTM = 1;
			else
				Forward_RTM = 0;	
	end
endmodule
