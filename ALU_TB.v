`timescale 1ns/1ns
module ALU_TB;

reg Clock;
reg [31:0] A, B;
reg [5:0] ALU_ctl;
wire [31:0] Zlow, Zhigh;

ALU DUT (A, B, ALU_ctl, Zhigh, Zlow);

initial
begin
	Clock = 0;
	forever #10 Clock = ~ Clock;
end

initial
begin
	A <= 16;
	B <= 4;
	ALU_ctl <= 3;
	
	#10 ALU_ctl <= 4;
	#10 ALU_ctl <= 5;
	#10 ALU_ctl <= 6;
	#10 ALU_ctl <= 7;
	#10 ALU_ctl <= 8;
	#10 ALU_ctl <= 9;
	#10 ALU_ctl <= 10;
	#10 ALU_ctl <= 11;
	#10 ALU_ctl <= 12;
	#10 ALU_ctl <= 13;
	#10 ALU_ctl <= 14;
	#10 ALU_ctl <= 15;
	#10 ALU_ctl <= 16;
	#10 ALU_ctl <= 17;
	
end
endmodule