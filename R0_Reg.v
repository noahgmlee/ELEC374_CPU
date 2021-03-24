module R0_Reg #(parameter VAL = 0
)(input clk, clr, enable, BAout, input [31:0] d, output reg [31:0] q);

initial q <= VAL;

always @ (posedge clk)
begin
	if (clr | BAout) begin
		q <= 32'b0;
	end else if (enable) begin
		q <= d;
	end
end

endmodule