module Negate (input [31:0] a, output [31:0] result);
	//we have to not the whole number then add 1
	wire [31:0] temp;
	wire cout;
	
	NOT_32 logical_NOT (a, temp);
	Adder_32 add_1 (temp, 32'd1, 1'd0, result, cout);
	
endmodule
