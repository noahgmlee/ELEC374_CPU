module C_SignExtended (input [31:0] d, output reg [31:0] q);

always @ (d) begin
	q[17:0] = d[17:0];
	q[31:18] = {d[18], d[18], d[18], d[18], d[18], d[18],
					d[18], d[18], d[18], d[18], d[18], d[18],
					d[18], d[18]};
end
endmodule