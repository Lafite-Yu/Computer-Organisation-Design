`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:05 11/07/2017 
// Design Name: 
// Module Name:    string 
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
module string(
    input clk,
    input clr,
    input [7:0] in,
    output reg out
    );
	
	integer state = 0;
	
	always @ (posedge clr or posedge clk) begin
		if (clr) begin
			state = 0;
			out = 0;
		end
		
		else begin
			case (state)
			0: begin
				if (in >= "0" && in <= "9") begin
					state <= 1;
					out <= 1;
				end
				else begin
					state <= 3;
					out <= 0;
				end
			end
			1: begin
				if ( in == "+" || in == "*") begin
					state = 2;
					out = 0;
				end
				else begin
					state <= 3;
					out = 0;
				end
			end
			2: begin
				if (in >= "0" && in <= "9") begin
					state <=  1;
					out <= 1;
				end
				else begin
					state <= 3;
					out <= 0;
				end
			end
			3: begin
				out <= 0;
			end 
			endcase
		end
	end
endmodule
