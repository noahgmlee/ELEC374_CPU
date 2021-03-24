module CON_FF (input CONin, input [31:0] Busin, input [1:0] IR_bits, output CONout);

reg [3:0] decode_out;
reg CON_D;
reg CON_Q;
assign CONout = CON_Q;

always @ (*) begin
	CON_D = 0;
	case (IR_bits)
		2'b00: begin
			 decode_out = 4'b0001;
			 end
		2'b01: begin
			 decode_out = 4'b0010;
			 end
		2'b10: begin
			 decode_out = 4'b0100;
			 end
		2'b11: begin
			 decode_out = 4'b1000;
			 end
	endcase
	
	if (Busin == 0 && decode_out[0]) begin
		CON_D = 1;
	end else if (Busin != 0 && decode_out[1]) begin
		CON_D = 1;
	end else if (Busin >= 0 && decode_out[2]) begin
		CON_D = 1;
	end else if (Busin[31] && decode_out[3]) begin
		CON_D = 1;
	end
	if (CONin) begin
		CON_Q = CON_D;
	end 
end
endmodule
		
		
			
