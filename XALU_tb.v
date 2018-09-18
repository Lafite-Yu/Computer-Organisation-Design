`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:45:43 12/24/2017
// Design Name:   XALU
// Module Name:   H:/Computer Organisation/Verilog/code/P6/XALU_tb.v
// Project Name:  P6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: XALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module XALU_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [31:0] A;
	reg [31:0] B;
	reg mult;
	reg div;
	reg HIWrite;
	reg LOWrite;
	reg read;

	// Outputs
	wire busy;
	wire [31:0] HI;
	wire [31:0] LO;

	// Instantiate the Unit Under Test (UUT)
	XALU uut (
		.clk(clk), 
		.reset(reset),
		.A(A), 
		.B(B), 
		.mult(mult), 
		.div(div), 
		.HIWrite(HIWrite), 
		.LOWrite(LOWrite), 
		.read(read), 
		.busy(busy), 
		.HI(HI), 
		.LO(LO)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		A = 32'd100;
		B = 32'd45;
		mult = 0;
		div = 0;
		HIWrite = 0;
		LOWrite = 0;
		read = 0;
        
		// Add stimulus here
		#10;
		reset = 0;
		
		#5;
		HIWrite = 1;
		
		#20;
		HIWrite = 0;
		
	end
    
	always #5 clk = ~clk;
endmodule

