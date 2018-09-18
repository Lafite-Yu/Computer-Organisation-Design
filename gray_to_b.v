`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:49:58 11/07/2017 
// Design Name: 
// Module Name:    gray_to_b 
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
module gray_counter(
	input clk,
	input reset_n,
	input [3:0] gray_in,
	output [3:0] gray_out
);


//格雷码转二进制

wire [3:0] bin_out;

gray_to_bin gray_to_bin_1(
	.gray_in (gray_wire),
	.bin_out (bin_out)
);

//二进制加一

wire [3:0] bin_add_wire;

assign bin_add_wire = bin_out + 1'b1;

//二进制转格雷码

wire [3:0] gray_wire;

reg [3:0] gray_out;

bin_to_gray bin_to_gray_1(
	.bin_in (bin_add_wire),
	.gray_out (gray_wire)
);

 

always @(posedge clk or negedge reset_n) begin
		if(reset_n == 1'b0) begin
			gray_out <= {4{1'b0}};
		end
		else begin
			gray_out <= gray_wire;
		end
	end
endmodule
