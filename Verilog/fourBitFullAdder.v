`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:55:28 10/25/2017 
// Design Name: 
// Module Name:    fourBitFullAdder 
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
module halfAdder(
    input [1:0] A,
    input [1:0] B,
    output  cout,
    output  [1:0] S 
    );
	 
	 assign {cout,S} = A + B;
endmodule
