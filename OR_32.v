module OR_32 (input [31:0] a, b, output [31:0] result);

reg [31:0] temp;
integer i;
always @(*) begin
	for (i = 0; i < 32; i = i + 1) begin
		temp[i] = a[i] | b[i];
	end
end
assign result = temp;
endmodule
