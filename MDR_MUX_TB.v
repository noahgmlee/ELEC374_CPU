module MDR_Mux_TB;

reg clk, clr, enable, Read;
reg [31:0] Busout, Mdatain;
wire [31:0] Mux_out;
wire [31:0] MDR_out;

MDR_Mux MDRM (Read, Busout, Mdatain, Mux_out);
Register MDR (clk, clr, enable, Mux_out, MDR_out);

	initial 
		begin
			clr = 0;
			clk = 0;
			forever #10 clk = ~ clk;
		end

initial
begin
	#10 Read <= 1;
		 enable <= 1;
		 Mdatain <= 69;
		 Busout <= 420;
	#30 Read <= 0;
	#50 $finish; 
	end
endmodule
		
	
