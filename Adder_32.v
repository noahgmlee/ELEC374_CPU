module Adder_32 (input [31:0] a, b, input cin, output [31:0] sum, output cout);
	
	wire [1:0] carry;
	assign carry[0] = cin;
	
	Adder_16 Adder_1 (a[15:0], b[15:0], carry[0], sum[15:0], carry[1]);
	Adder_16 Adder_2 (a[31:16], b[31:16], carry[1], sum[31:16], cout);

endmodule

module Adder_16 (input [15:0] a, b, input cin, output [15:0] sum, output cout);

	wire [3:0] carry;
	assign carry[0] = cin;
	
	CLA_4bits Adder_1 (a[3:0], b[3:0], carry[0], sum[3:0], carry[1]);
	CLA_4bits Adder_2 (a[7:4], b[7:4], carry[1], sum[7:4], carry[2]);
	CLA_4bits Adder_3 (a[11:8], b[11:8], carry[2], sum[11:8], carry[3]);
	CLA_4bits Adder_4 (a[15:12], b[15:12], carry[3], sum[15:12], cout);

endmodule

module CLA_4bits (input [3:0] a, b, input cin, output [3:0] sum, output cout);
	
	wire [3:0] carry;
	wire [3:0] P, G;
	
	BCell b0(a[0], b[0], carry[0], sum[0], G[0], P[0]);
	BCell b1(a[1], b[1], carry[1], sum[1], G[1], P[1]);
	BCell b2(a[2], b[2], carry[2], sum[2], G[2], P[2]);
	BCell b3(a[3], b[3], carry[3], sum[3], G[3], P[3]);
	
	assign carry[0] = cin;
	assign carry[1] = G[0] | (P[0] & carry[0]);
	assign carry[2] = G[1] | (P[1] & carry[1]);
	assign carry[3] = G[2] | (P[2] & carry[2]);
	assign cout = G[3] | (P[3] & carry[3]);

endmodule
	

module BCell (input a, b, cin, output sum, G, P);
	assign G = a&b;
	assign P = a ^ b;
	assign sum = a ^ b ^ cin;
endmodule
