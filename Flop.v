`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:41:03 12/13/2017 
// Design Name: 
// Module Name:    Flop_RC 
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
module Flop_RC #(parameter WIDTH = 32)
	(
    input clk,
	input reset,
    input clr,
    input [WIDTH-1:0] in,
    output reg [WIDTH-1:0] out = 0
    );
	
	always @(posedge clk) begin
		if (clr || reset) 
			out <= 0;
		else 
			out <= in;
	end
endmodule

module Flop_R #(parameter WIDTH = 32)
	(
    input clk,
	input reset,
    input [WIDTH-1:0] in,
    output reg [WIDTH-1:0] out = 0
    );
	
	always @(posedge clk) begin
		if (reset) 
			out <= 0;
		else 
			out <= in;
	end
endmodule

module Flop_NenRC #(parameter WIDTH = 32)
	(
    input clk,
	input Nen,
	input reset,
    input clr,
    input [WIDTH-1:0] in,
    output reg [WIDTH-1:0] out = 0
    );
	
	always @(posedge clk) begin
		if (clr || reset) 
			out <= 0;
		else if (!Nen)
			out <= in;
	end
endmodule
