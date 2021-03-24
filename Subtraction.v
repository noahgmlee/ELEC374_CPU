module Subtraction (input [31:0] a, b, input cin, output [31:0] result, output cout);
	//negate the second value and add them
	wire [31:0] temp;
	Negate negate_breg (b, temp);
	Adder_32 subtracting (a, temp, cin, result, cout);
	
endmodule
