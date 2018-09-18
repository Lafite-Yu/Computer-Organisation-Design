`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:06 11/29/2017 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input [31:0] data,
    input clk,
    input reset,
    output reg [31:0] out = 32'h00003000
    );
	
	always @(posedge clk or posedge reset) begin
		if (reset == 1) begin
			out = 32'h00003000;
		end
		else begin
			out = data;
		end
	end
endmodule
