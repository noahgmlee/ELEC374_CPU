module NOT_32 (input [31:0] a, output [31:0] result);
	reg [31:0] temp;
	integer i;
	assign result = temp;
	always @ (a) begin
		for (i = 0; i < 32; i = i + 1) 
		begin
			temp[i] = !a[i];
		end
	end
endmodule
