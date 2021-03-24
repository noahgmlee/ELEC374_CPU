module BusMux_TB;

//reg [31:0] BusMuxin_R2, BusMuxin_R4, BusMuxin_R5;
reg [31:0] temp;
reg R2out, R4out, R5out, Clock, clr, R2in, R4in, R5in;
wire [31:0] BusMuxout, R2data, R4data, R5data;

BusMux DUT (32'b0, 32'b0, R2data, 32'b0, R4data,
				R5data, 32'b0, 32'b0, 32'b0, 32'b0,
				32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
				32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
				32'b0, 32'b0, 32'b0, 32'b0,
				1'b0, 1'b0, R2out, 1'b0, R4out, R5out, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
				1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
				1'b0, 1'b0,
				BusMuxout);
				
Register R2 (Clock, clr, R2in, temp, R2data);
Register R4 (Clock, clr, R4in, BusMuxout, R4data);
Register R5 (Clock, clr, R5in, BusMuxout, R5data);

initial 
	begin
		Clock = 0;
		clr = 0;
		temp = 34;
		R2in = 1;
		R2out = 0;
		R4out = 0;
		R5out = 0;
		forever #10 Clock = ~ Clock;
	end

initial 
	begin
		#20 R2out <= 1;
			 R4in <= 1;
		#15 R2out <= 0;
			 R4out <= 1;
			 R5in <= 1;
		#30 R4out <= 0;
			 R5out <= 1;
	end
endmodule
