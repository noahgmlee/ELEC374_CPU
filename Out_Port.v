module Out_Port (input clk, clr, Out_Portin, input [31:0] d, output reg [31:0] q);

always @ (posedge clk)
begin
	if (clr) begin
		q <= 32'b0;
	end else if (Out_Portin) begin
		q <= d;
	end
end

endmodule