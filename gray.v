`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:42:36 11/07/2017 
// Design Name: 
// Module Name:    gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output reg [2:0] Output = 0,
    output reg Overflow = 0
    );
	 
	reg [2:0] n;
	reg o;
	
	initial begin
		n <= 0;
		o = 0;
	end
		
	 always @(posedge Clk) begin
		if(Reset) begin
			n = 0;
			o = 0;
			Overflow = 0;
		end
		else begin
			if (En) begin
				n = n + 1;
				if (n == 7) begin
					o <= 1;
				end
				if (o) begin
					Overflow <= 1;
				end
			end
		end
		Output <=  (n >> 1) ^ n; 
	end


endmodule
