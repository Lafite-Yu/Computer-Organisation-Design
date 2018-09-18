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
	input busy,
	input [2:0] XALUOp_E,
	output stall,
	output reg [2:0] Forward_RSD, Forward_RTD = 0, 
	output reg [2:0] Forward_RSE, Forward_RTE = 0, 
	output reg Forward_RTM = 0
    );

	`define rs 25:21
	`define rt 20:16
	`define rd 15:11
	
	`define Nop 4'd0
	`define Load 4'd1
	`define Store 4'd2
	`define Cal_R 4'd3
	`define XALU_R 4'd4
	`define XALU_W 4'd5
	`define Cal_I 4'd6
	`define BCB 4'd7
	`define BCZ 4'd8
	`define Jump 4'd9
	`define Jr 4'd10
	`define Jal 4'd11
	`define Jalr 4'd12
	`define Unknown 4'b1111

	wire [3:0] IR_D_Type, IR_E_Type, IR_M_Type, IR_W_Type;
	IR_Type_Judger Type_JudgerD(reset, IR_D, IR_D_Type);
	IR_Type_Judger Type_JudgerE(reset, IR_E, IR_E_Type);
	IR_Type_Judger Type_JudgerM(reset, IR_M, IR_M_Type);
	IR_Type_Judger Type_JudgerW(reset, IR_W, IR_W_Type);
	
	// Stall
	wire stall_bcb, stall_bcz, stall_xalu, stall_calr, stall_cali, stall_ld, stall_st, stall_jr;
	assign stall_bcb = IR_D_Type == `BCB &
					 ( ( IR_E_Type == `Cal_R & ( IR_D[`rs] == IR_E[`rd] | IR_D[`rt] == IR_E[`rd] ) ) |
					( IR_E_Type == `Cal_I  & ( IR_D[`rs] == IR_E[`rt] | IR_D[`rt] == IR_E[`rt] ) ) |
					( IR_E_Type == `Load & ( IR_D[`rs] == IR_E[`rt] | IR_D[`rt] == IR_E[`rt] ) ) |
					( IR_M_Type == `Load & ( IR_D[`rs] == IR_M[`rt] | IR_D[`rt] == IR_M[`rt] ) ) );
	assign stall_bcz = IR_D_Type == `BCZ &
					 ( ( IR_E_Type == `Cal_R & IR_D[`rs] == IR_E[`rd] ) |
					( IR_E_Type == `Cal_I  & IR_D[`rs] == IR_E[`rt] ) |
					( IR_E_Type == `Load & IR_D[`rs] == IR_E[`rt] ) |
					( IR_M_Type == `Load & IR_D[`rs] == IR_M[`rt] ) );
	assign stall_calr = IR_D_Type == `Cal_R &
						( IR_E_Type == `Load & ( IR_D[`rs] == IR_E[`rt] | IR_D[`rt] == IR_E[`rt] ) );
						
	assign stall_xalu = (IR_D_Type == `XALU_R || IR_D_Type == `XALU_W) & ( busy | XALUOp_E == 3'b110 | XALUOp_E == 3'b111 |XALUOp_E == 3'b100 |XALUOp_E == 3'b101 ) ;	
	
	assign stall_cali = IR_D_Type == `Cal_I &
						( IR_E_Type == `Load  & IR_D[`rs] == IR_E[`rt] );
	assign stall_ld = IR_D_Type == `Load & 
						( IR_E_Type == `Load & IR_D[`rs] == IR_E[`rt] );
	assign stall_st = IR_D_Type == `Store &
						( IR_E_Type == `Load & IR_D[`rs] == IR_E[`rt] );
	assign stall_jr = (IR_D_Type == `Jr | IR_D_Type == `Jalr) &
					 ( ( IR_E_Type == `Cal_R & IR_D[`rs] == IR_E[`rd] ) |
					( IR_E_Type == `Cal_I  & IR_D[`rs] == IR_E[`rt] ) |
					( IR_E_Type == `Load & IR_D[`rs] == IR_E[`rt] ) |
					( IR_M_Type == `Load & IR_D[`rs] == IR_M[`rt] ) );
	assign stall = stall_bcb | stall_bcz | stall_xalu | stall_calr | stall_cali | stall_ld | stall_st | stall_jr;
	
	wire D_RS, D_RT, E_RS, E_RT, M_RT;
	assign D_RS = (IR_D_Type == `BCB || IR_D_Type == `BCZ || IR_D_Type == `Jr || IR_D_Type == `Jalr);
	assign D_RT = (IR_D_Type == `BCB);
	assign E_RS = (IR_E_Type == `Cal_R || IR_E_Type == `XALU_W || IR_E_Type == `Cal_I || IR_E_Type == `Load || IR_E_Type == `Store);
	assign E_RT = (IR_E_Type == `Cal_R || IR_E_Type == `XALU_W || IR_E_Type == `Store);
	assign M_RT = (IR_M_Type == `Store);
	
	always @* begin
	// Forward
		// IR_D
		if (D_RS && IR_D[`rs] != 0) 
			if ( (IR_E_Type == `Jal && IR_D[`rs] == 5'b11111) || (IR_E_Type == `Jalr && IR_D[`rs] == IR_E[`rd]) )
				Forward_RSD = 1;
			else if ( (IR_M_Type == `Cal_R && IR_D[`rs] == IR_M[`rd]) || (IR_M_Type == `Cal_I && IR_D[`rs] == IR_M[`rt]) )
				Forward_RSD = 2;
			else if ( (IR_M_Type == `Jal && IR_D[`rs] == 5'b11111) || (IR_M_Type == `Jalr && IR_D[`rs] == IR_M[`rd]) )
				Forward_RSD = 3;
			else if ( (IR_W_Type == `Cal_R && IR_D[`rs] == IR_W[`rd]) || (IR_W_Type == `XALU_R && IR_D[`rs] == IR_W[`rd]) || ( IR_W_Type == `Cal_I && IR_D[`rs] == IR_W[`rt] ) || (IR_W_Type == `Load && IR_D[`rs] == IR_W[`rt]) || (IR_W_Type == `Jal && IR_D[`rs] == 5'b11111) || (IR_W_Type == `Jalr && IR_D[`rs] == IR_W[`rd]) )
				Forward_RSD = 4;
			else if (IR_M_Type == `XALU_R && IR_D[`rs] == IR_M[`rd])
				Forward_RSD = 5;
			else
				Forward_RSD = 0;
		else
			Forward_RSD = 0;
					
		if (D_RT && IR_D[`rt] != 0)
			if ( (IR_E_Type == `Jal && IR_D[`rt] == 5'b11111) || (IR_E_Type == `Jalr && IR_D[`rt] == IR_E[`rd]) )
				Forward_RTD = 1;
			else if ( (IR_M_Type == `Cal_R && IR_D[`rt] == IR_M[`rd]) || (IR_M_Type == `Cal_I && IR_D[`rt] == IR_M[`rt]) )
				Forward_RTD = 2;
			else if ( (IR_M_Type == `Jal && IR_D[`rt] == 5'b11111) || (IR_M_Type == `Jalr && IR_D[`rt] == IR_M[`rd]) )
				Forward_RTD = 3;
			else if ( (IR_W_Type == `Cal_R && IR_D[`rt] == IR_W[`rd]) || (IR_W_Type == `XALU_R && IR_D[`rt] == IR_W[`rd]) || ( IR_W_Type == `Cal_I && IR_D[`rt] == IR_W[`rt] ) || (IR_W_Type == `Load && IR_D[`rt] == IR_W[`rt]) || (IR_W_Type == `Jal && IR_D[`rt] == 5'b11111) || (IR_W_Type == `Jalr && IR_D[`rt] == IR_W[`rd]) )
				Forward_RTD = 4;
			else if (IR_M_Type == `XALU_R && IR_D[`rt] == IR_M[`rd])
				Forward_RTD = 5;
			else
				Forward_RTD = 0;
		else
			Forward_RTD = 0;
					
		// IR_E
		if ( E_RS && IR_E[`rs] != 0 )
			if ( (IR_M_Type == `Cal_R && IR_E[`rs] == IR_M[`rd]) || (IR_M_Type == `Cal_I && IR_E[`rs] == IR_M[`rt]) )
				Forward_RSE = 1;
			else if ((IR_M_Type == `Jal && IR_E[`rs] == 5'b11111) || (IR_M_Type == `Jalr && IR_E[`rs] == IR_M[`rd]))
				Forward_RSE = 2;
			else if ( (IR_W_Type == `Cal_R && IR_E[`rs] == IR_W[`rd]) || (IR_W_Type == `XALU_R && IR_E[`rs] == IR_W[`rd]) || ( IR_W_Type == `Cal_I && IR_E[`rs] == IR_W[`rt] ) || (IR_W_Type == `Load && IR_E[`rs] == IR_W[`rt]) || (IR_W_Type == `Jal && IR_E[`rs] == 5'b11111) || (IR_W_Type == `Jalr && IR_E[`rs] == IR_W[`rd]) )
				Forward_RSE = 3;
			else if (IR_M_Type == `XALU_R && IR_E[`rs] == IR_M[`rd])
				Forward_RSE = 4;
			else
				Forward_RSE = 0;
		else
			Forward_RSE = 0;
					
		if ( E_RT && IR_E[`rt] != 0 )
			if ( (IR_M_Type == `Cal_R && IR_E[`rt] == IR_M[`rd]) || (IR_M_Type == `Cal_I && IR_E[`rt] == IR_M[`rt]) )
				Forward_RTE = 1;
			else if ((IR_M_Type == `Jal && IR_E[`rt] == 5'b11111) || (IR_M_Type == `Jalr && IR_E[`rt] == IR_M[`rd]))
				Forward_RTE = 2;
			else if ( (IR_W_Type == `Cal_R && IR_E[`rt] == IR_W[`rd]) || (IR_W_Type == `XALU_R && IR_E[`rt] == IR_W[`rd]) || ( IR_W_Type == `Cal_I && IR_E[`rt] == IR_W[`rt] ) || (IR_W_Type == `Load && IR_E[`rt] == IR_W[`rt]) || (IR_W_Type == `Jal && IR_E[`rt] == 5'b11111) || (IR_W_Type == `Jalr && IR_E[`rt] == IR_W[`rd]) )
				Forward_RTE = 3;
			else if (IR_M_Type == `XALU_R && IR_E[`rt] == IR_M[`rd])
				Forward_RTE = 4;
			else
				Forward_RTE = 0;	
		else 
			Forward_RTE = 0;	
			
		// IR_M
		if ( M_RT && IR_M[`rt] != 0)
			if ( (IR_W_Type == `Cal_R && IR_M[`rt] == IR_W[`rd]) || ( IR_W_Type == `Cal_I && IR_M[`rt] == IR_W[`rt] ) || (IR_W_Type == `Load && IR_M[`rt] == IR_W[`rt]) || (IR_W_Type == `Jal && IR_M[`rt] == 5'b11111) )
				Forward_RTM = 1;
			else
				Forward_RTM = 0;
		else	
			Forward_RTM = 0;
	end
	
endmodule
