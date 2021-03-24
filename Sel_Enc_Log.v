module Sel_Enc_Log (input Gra, Grb, Grc, Rin, Rout, BAout, input [31:0] IR,
						  output [15:0] GPRin, GPRout);
	
reg [3:0] Decoder_in;	
reg [15:0] Decoder_out;
reg [15:0] in, out;
assign GPRin = in;
assign GPRout = out;

initial
begin
in <= 0;
out <= 0;
end

always @ (*) begin
	if (Gra) begin
		Decoder_in <= IR [26:23];
	end else if (Grb) begin
		Decoder_in <= IR [22:19];
	end else if (Grc) begin
		Decoder_in <= IR [18:15];
	end else begin
		in = 0;
		out = 0;
	end
	
	case (Decoder_in) 
		4'b0000: begin
					Decoder_out = 16'b0000_0000_0000_0001;
					end
		4'b0001: begin
					Decoder_out = 16'b0000_0000_0000_0010;
					end
		4'b0010: begin
					Decoder_out = 16'b0000_0000_0000_0100;
					end
		4'b0011: begin
					Decoder_out = 16'b0000_0000_0000_1000;
					end
		4'b0100: begin
					Decoder_out = 16'b0000_0000_0001_0000;
					end
		4'b0101: begin
					Decoder_out = 16'b0000_0000_0010_0000;
					end
		4'b0110: begin
					Decoder_out = 16'b0000_0000_0100_0000;
					end
		4'b0111: begin
					Decoder_out = 16'b0000_0000_1000_0000;
					end
		4'b1000: begin
					Decoder_out = 16'b0000_0001_0000_0000;
					end
		4'b1001: begin
					Decoder_out = 16'b0000_0010_0000_0000;
					end
		4'b1010: begin
					Decoder_out = 16'b0000_0100_0000_0000;
					end
		4'b1011: begin
					Decoder_out = 16'b0000_1000_0000_0000;
					end
		4'b1100: begin
					Decoder_out = 16'b0001_0000_0000_0000;
					end
		4'b1101: begin
					Decoder_out = 16'b0010_0000_0000_0000;
					end
		4'b1110: begin
					Decoder_out = 16'b0100_0000_0000_0000;
					end
		4'b1111: begin
					Decoder_out = 16'b1000_0000_0000_0000;
					end
		default: begin
					Decoder_out = 16'b0;
					end
	endcase
	if (Rin) begin 
		in = Decoder_out;
		out = 0;
	end else if (Rout | BAout) begin
		out = Decoder_out;
		in = 0;
	end
	
end
endmodule
					
		