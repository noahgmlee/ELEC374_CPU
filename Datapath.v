module Datapath (input PCout, Zlowout, Zhighout, MDRout, MARin, Zin, PCin, MDRin, IRin, Yin, 
							  LOin, HIin, IncPC, Read, Write, clk, CONin, Gra, Grb, Grc, Rin, Rout, 
							  BAout, Cout, HIout, LOout, Out_Portin, InPortout,
					  output [31:0] Busout, Zlow_out, Zhi_out, R1_out, R0_out);
					  
//wire [31:0] R0_out;
//wire [31:0] R1_out;
wire [31:0] R2_out;
wire [31:0] R3_out;
wire [31:0] R4_out;
wire [31:0] R5_out;
wire [31:0] R6_out;
wire [31:0] R7_out;
wire [31:0] R8_out;
wire [31:0] R9_out;
wire [31:0] R10_out;
wire [31:0] R11_out;
wire [31:0] R12_out;
wire [31:0] R13_out;
wire [31:0] R14_out;
wire [31:0] R15_out;

wire [31:0] PC_out;
wire [31:0] IR_out;
wire [31:0] Y_out;
wire [31:0] Z_out;
wire [31:0] MAR_out;
wire [31:0] HI_out;
wire [31:0] LO_out;
//wire [31:0] Zhi_out;
//wire [31:0] Zlow_out;
wire [31:0] MDR_out;
wire [31:0] InPort_out;
wire [31:0] OutPort_out;
wire [31:0] C_out;

wire [31:0] MDMux_out;
wire [31:0] ALU_low;
wire [31:0] ALU_high;
wire [31:0] Mdatain;
wire [15:0] GPReg_in;
wire [15:0] GPReg_out;
wire clr;

wire CON_out;

C_SignExtended CS (IR_out, C_out);

R0_Reg R0 (clk, clr, GPReg_in[0], BAout, Busout, R0_out);
Register R1 (clk, clr, GPReg_in[1], Busout, R1_out);
Register R2 (clk, clr, GPReg_in[2], Busout, R2_out);
Register R3 (clk, clr, GPReg_in[3], Busout, R3_out);
Register R4 (clk, clr, GPReg_in[4], Busout, R4_out);
Register R5 (clk, clr, GPReg_in[5], Busout, R5_out);
Register R6 (clk, clr, GPReg_in[6], Busout, R6_out);
Register R7 (clk, clr, GPReg_in[7], Busout, R7_out);
Register R8 (clk, clr, GPReg_in[8], Busout, R8_out);
Register R9 (clk, clr, GPReg_in[9], Busout, R9_out);
Register R10 (clk, clr, GPReg_in[10], Busout, R10_out);
Register R11 (clk, clr, GPReg_in[11], Busout, R11_out);
Register R12 (clk, clr, GPReg_in[12], Busout, R12_out);
Register R13 (clk, clr, GPReg_in[13], Busout, R13_out);
Register R14 (clk, clr, GPReg_in[14], Busout, R14_out);
Register R15 (clk, clr, R15in, Busout, R15_out);

Register IR (clk, clr, IRin, Busout, IR_out);
Register PC (clk, clr, PCin, Busout, PC_out);
Register Zlow (clk, clr, Zin, ALU_low, Zlow_out);
Register Zhigh (clk, clr, Zin, ALU_high, Zhi_out);
Register Y (clk, clr, Yin, Busout, Y_out);
Register #(10) HI (clk, clr, HIin, Busout, HI_out);
Register #(5) LO (clk, clr, LOin, Busout, LO_out);
Register MAR (clk, clr, MARin, Busout, MAR_out);

MDR_Mux MM (Read, Busout, Mdatain, MDMux_out);
Register MDR (clk, clr, MDRin, MDMux_out, MDR_out);

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

Out_Port OP (clk, clr, Out_Portin, Busout, OutPort_out);
In_Port #(10) IP (clk, clr, 1'b0, Busout, InPort_out);

endmodule		  
