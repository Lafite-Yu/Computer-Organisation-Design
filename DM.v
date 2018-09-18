`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:15 11/29/2017 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input reset,
    input [31:0] A,
    input [31:0] WD,
    input [1:0] MemWrite,
	input [31:0] PC,
    output [31:0] RD
    );
	
	wire [11:0] addr;
	assign addr = A[13:2];
	integer i;
	reg [31:0] RAM [4095:0];
	
	assign RD = RAM[addr];
	
	always @ (posedge clk) begin
		if (reset)
			for (i = 0; i < 4096; i = i + 1)
				RAM[i] <= 0;
		else begin
			case (MemWrite)
				2'b00:; // nop
				2'b01: begin // byte
					case(A[1:0])
						0: begin
							$display("%d@%h: *%h <= %h", $time, PC, {A[31:2], 2'b00}, {RAM[addr][31:8], WD[7:0]});
							RAM[addr][7:0] <= WD[7:0];
						end
						1: begin
							$display("%d@%h: *%h <= %h", $time, PC, {A[31:2], 2'b00}, {RAM[addr][31:16], WD[7:0], RAM[addr][7:0]});
							RAM[addr][15:8] <= WD[7:0];
						end
						2: begin
							$display("%d@%h: *%h <= %h", $time, PC, {A[31:2], 2'b00}, {RAM[addr][31:24], WD[7:0], RAM[addr][15:0]});
							RAM[addr][23:16] <= WD[7:0];
						end
						3:begin
							//$display("%d@%h: *%h <= %h", $time, PC, {A[31:2], 2'b00}, RAM[addr]);
							$display("%d@%h: *%h <= %h", $time, PC, {A[31:2], 2'b00}, {WD[7:0], RAM[addr][23:0]});
							RAM[addr][31:24] <= WD[7:0];
						end
					endcase
				end
				2'b10: begin// half
					case(A[1])
						0: begin
							$display("%d@%h: *%h <= %h", $time, PC, {A[31:2], 2'b00}, {RAM[addr][31:16], WD[15:0]});
							RAM[addr][15:0] <= WD[15:0];
						end
						1: begin
							$display("%d@%h: *%h <= %h", $time, PC, {A[31:2], 2'b00}, {WD[15:0], RAM[addr][15:0]});
							RAM[addr][31:16] <= WD[15:0];
						end
					endcase
				end
				2'b11: begin // word
					$display("%d@%h: *%h <= %h", $time, PC, {A[31:2], 2'b00}, WD);
					RAM[addr] <= WD;
				end
			endcase
		end
	end
endmodule
