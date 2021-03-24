module Register #(parameter VAL = 0
)(input clk, clr, enable, input [31:0] d, output reg [31:0] q);

initial q <= VAL;

always @ (posedge clk)
begin
	if (clr) begin
		q <= 32'b0;
	end else if (enable) begin
		q <= d;
	end
end

endmodule


