`timescale 1ns/1ns
module control_unit_tb;

reg	Clock, CU_clk, Reset, Stop;
wire	[31:0] Busout;
	
Datapath DUT (Clock, CU_clk, Reset, Stop, Busout);
	
initial 
	begin
		Clock = 0;
		forever #10 Clock = ~ Clock;
	end

initial
	begin
		CU_clk = 1;
		forever #20 CU_clk = ~ CU_clk;
	end

initial 
	begin
		Reset = 0;
		Stop = 0;
	end
	
endmodule

