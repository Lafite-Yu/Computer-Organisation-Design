`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:16:13 10/27/2017 
// Design Name: 
// Module Name:    LED 
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
module LED(
    input x3,
    input x2,
    input x1,
    input x0,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
    );
	 
	 wire nx3, nx2, nx1, nx0;
	 
	 not(nx3, x3);
	 not(nx2, x2);
	 not(nx1, x1);
	 not(nx0, x0);
	 
	 wire a1, a2, a3, a4;
	 and(a1, nx2, nx0);
	 assign a2 = x1;
	 and(a3, x2, x0);
	 assign a4 = x3;
	 or(a, a1, a2, a3, a4);
	 
	 wire b1, b2, b3, b4;
	 and(b1, nx1, nx0);
	 and(b2, x2, nx1);
	 and(b3, x2, nx0);
	 assign b4 = x3;
	 or(b, b1, b2, b3, b4);
	 
	 wire c1, c2, c3, c4;
	 and(c1, nx2, nx0);
	 and(c2, x1, nx0);
	 and(c3, x3, x1);
	 and(c4, x3, x2);
	 or(c, c1, c2, c3, c4);
	 
	 wire d1, d2, d3, d4, d5;
	 and(d1, nx3, nx2, nx0);
	 and(d2, nx2, x1, x0);
	 and(d3, x2, nx1, x0);
	 and(d4, x2, x1, nx0);
	 and(d5, x3, nx1);
	 or(d, d1, d2, d3, d4, d5);
	 
	 wire e1, e2, e3, e4, e5;
	 and(e1, nx3, nx1);
	 and(e2, nx3, x0);
	 and(e3, nx1, x0);
	 and(e4, nx3, x2);
	 and(e5, x3, nx2);
	 or(e, e1, e2, e3, e4, e5);
	 
	 wire f1, f2, f3, f4;
	 and(f1, nx3, nx1, nx0);
	 assign f2 = nx2;
	 and(f3, nx3, x1, x0);
	 and(f4, x3, nx1, x0);
	 or(f, f1, f2, f3, f4);
	 
	 wire g1, g2, g3, g4, g5;
	 and(g1, nx2, x1);
	 and(g2, x1, nx0);
	 and(g3, nx3, x2, nx1);
	 and(g4, x3, nx2);
	 and(g5, x3, x1);
	 or(g, g1, g2, g3, g4, g5);	 

endmodule
