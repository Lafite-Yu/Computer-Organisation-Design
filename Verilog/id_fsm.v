`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:47:25 10/24/2017 
// Design Name: 
// Module Name:    id_fsm 
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
module id_fsm(
    input [7:0] char,
    input clk,
    output reg out = 0
    );
	 
	reg [1:0] state;
	initial begin
		state = 0;
	end
	
	always @(posedge clk) begin
		case (state)
			0:
				begin
					//$display("%d\n", state);
					if (("a" <= char && char <= "z") || ("A" <= char && char <= "Z")) begin
						state <= 1;
						out <= 0;
					end
					else begin
						state <= 0;
						out <= 0;
					end
				end
			1:
				begin
					//$display("%d\n", state);
					if ("0" <= char && char <= "9") begin
						state <= 2;
						out <= 1;
					end
					else if (("a" <= char && char <= "z") || ("A" <= char && char <= "Z")) begin
						state <= 1;
						out <= 0;
					end
					else begin
						state <= 0;
						out <= 0;
					end
				end
			2:
				begin
					//$display("%d\n", state);
					if (("a" <= char && char <= "z") || ("A" <= char && char <= "Z")) begin
						state <= 1;
						out <= 0;
					end
					else if ("0" <= char && char <= "9") begin
						state <= 2;
						out <= 1;
					end
					else begin
						state <= 0;
						out <= 0;
					end
				end
		endcase
	end
endmodule
