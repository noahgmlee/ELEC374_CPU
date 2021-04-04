module Datapath (input clk, CU_clk, Reset, Stop,
					  output [31:0] Busout);

wire Gra, Grb, Grc, Rin, Rout, R15in, HIin, LOin, CONin, PCin, IRin, Yin, Zin, MARin, MDRin, OutPortin, 
	  Cout, BAout, PCout, MDRout, Zhighout, Zlowout, HIout, LOout, InPortout, IncPC, Read, Write, Clear,
	  CON_out, Run;
					  
wire [31:0] R0_out1, R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, 
				R8_out, R9_out, R10_out, R11_out, R12_out, R13_out, R14_out, R15_out;

wire [31:0] PC_out, IR_out, Y_out, Z_out, MAR_out, HI_out, LO_out, MDR_out, InPort_out, 
				OutPort_in, OutPort_out, C_out, MDMux_out, ALU_low, ALU_high, Mdatain,
				Zlow_out, Zhi_out;

wire [15:0] GPReg_in, GPReg_out;

C_SignExtended CS (IR_out, C_out);

R0_Mux	R0mux (BAout, 32'b0, R0_out1, R0_out);
Register R0 (clk, Clear, GPReg_in[0], Busout, R0_out1);
Register R1 (clk, Clear, GPReg_in[1], Busout, R1_out);
Register R2 (clk, Clear, GPReg_in[2], Busout, R2_out);
Register R3 (clk, Clear, GPReg_in[3], Busout, R3_out);
Register R4 (clk, Clear, GPReg_in[4], Busout, R4_out);
Register R5 (clk, Clear, GPReg_in[5], Busout, R5_out);
Register R6 (clk, Clear, GPReg_in[6], Busout, R6_out);
Register R7 (clk, Clear, GPReg_in[7], Busout, R7_out);
Register R8 (clk, Clear, GPReg_in[8], Busout, R8_out);
Register R9 (clk, Clear, GPReg_in[9], Busout, R9_out);
Register R10 (clk, Clear, GPReg_in[10], Busout, R10_out);
Register R11 (clk, Clear, GPReg_in[11], Busout, R11_out);
Register R12 (clk, Clear, GPReg_in[12], Busout, R12_out);
Register R13 (clk, Clear, GPReg_in[13], Busout, R13_out);
Register R14 (clk, Clear, GPReg_in[14], Busout, R14_out);
Register15 R15 (clk, Clear, GPReg_in[15], R15in, Busout, R15_out);

Register IR (clk, Clear, IRin, Busout, IR_out);
Register PC (clk, Clear, PCin, Busout, PC_out);
Register Zlow (clk, Clear, Zin, ALU_low, Zlow_out);
Register Zhigh (clk, Clear, Zin, ALU_high, Zhi_out);
Register Y (clk, Clear, Yin, Busout, Y_out);
Register HI (clk, Clear, HIin, Busout, HI_out);
Register LO (clk, Clear, LOin, Busout, LO_out);
Register MAR (clk, Clear, MARin, Busout, MAR_out);

MDR_Mux MM (Read, Busout, Mdatain, MDMux_out);
Register MDR (clk, Clear, MDRin, MDMux_out, MDR_out);

BusMux BM (.BusMuxin_R0(R0_out), .BusMuxin_R1(R1_out), .BusMuxin_R2(R2_out), .BusMuxin_R3(R3_out),
			  .BusMuxin_R4(R4_out), .BusMuxin_R5(R5_out), .BusMuxin_R6(R6_out), .BusMuxin_R7(R7_out),
			  .BusMuxin_R8(R8_out), .BusMuxin_R9(R9_out), .BusMuxin_R10(R10_out), .BusMuxin_R11(R11_out),
			  .BusMuxin_R12(R12_out), .BusMuxin_R13(R13_out), .BusMuxin_R14(R14_out), .BusMuxin_R15(R15_out),
			  .BusMuxin_HI(HI_out), .BusMuxin_LO(LO_out), .BusMuxin_Zhi(Zhi_out), .BusMuxin_Zlo(Zlow_out),
			  .BusMuxin_PC(PC_out), .BusMuxin_MDR(MDR_out), .BusMuxin_InPort(InPort_out), .C_sign_extended(C_out),
			  .R0out(GPReg_out[0]), .R1out(GPReg_out[1]), .R2out(GPReg_out[2]), .R3out(GPReg_out[3]), .R4out(GPReg_out[4]), 
			  .R5out(GPReg_out[5]), .R6out(GPReg_out[6]), .R7out(GPReg_out[7]), .R8out(GPReg_out[8]), .R9out(GPReg_out[9]), 
			  .R10out(GPReg_out[10]), .R11out(GPReg_out[11]), .R12out(GPReg_out[12]), .R13out(GPReg_out[13]), .R14out(GPReg_out[14]),
			  .R15out(GPReg_out[15]), .HIout(HIout), .LOout(LOout), .ZHIout(Zhighout), .ZLOout(Zlowout), .PCout(PCout), 
			  .MDRout(MDRout), .InPortout(InPortout), .Cout(Cout), .BusMuxout(Busout));

ALU alu (Y_out, Busout, IR_out[31:27], IncPC, ALU_high, ALU_low);

Sel_Enc_Log SEL (Gra, Grb, Grc, Rin, Rout, BAout, IR_out, GPReg_in, GPReg_out);

CON_FF CFF (CONin, Busout, IR_out[20:19], CON_out);

Ram	Ram_inst (
	.address ( MAR_out ),
	.clock ( clk ),
	.data ( MDR_out ),
	.wren ( Write ),
	.q ( Mdatain )
	);

Out_Port OP (clk, Clear, Out_Portin, Busout, OutPort_out);
In_Port #(10) IP (clk, Clear, 1'b0, Busout, InPort_out);

control_unit CU (Gra, Grb, Grc, Rin, Rout, R15in, HIin, LOin, CONin, PCin, IRin, Yin, Zin, MARin, MDRin, 
					  Out_Portin, Cout, BAout, PCout, MDRout, Zhighout, Zlowout, HIout, LOout, InPortout, 
					  IncPC, Read, Write, Clear, Run, IR_out, CU_clk, Reset, Stop, CON_out);

endmodule		  
