module BusMux (input [31:0] BusMuxin_R0, BusMuxin_R1, BusMuxin_R2, BusMuxin_R3, BusMuxin_R4,
									 BusMuxin_R5, BusMuxin_R6, BusMuxin_R7, BusMuxin_R8, BusMuxin_R9,
									 BusMuxin_R10, BusMuxin_R11, BusMuxin_R12, BusMuxin_R13, BusMuxin_R14,
									 BusMuxin_R15, BusMuxin_HI, BusMuxin_LO, BusMuxin_Zhi, BusMuxin_Zlo,
									 BusMuxin_PC, BusMuxin_MDR, BusMuxin_InPort, C_sign_extended,
					input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out,
							R11out, R12out, R13out, R14out, R15out, HIout, LOout, ZHIout, ZLOout, PCout, MDRout,
							InPortout, Cout,
					output [31:0] BusMuxout);
					
assign BusMuxout = R0out ? BusMuxin_R0 : 
						 R1out ? BusMuxin_R1 :
						 R2out ? BusMuxin_R2 :
						 R3out ? BusMuxin_R3 :
						 R4out ? BusMuxin_R4 :
						 R5out ? BusMuxin_R5 :
						 R6out ? BusMuxin_R6 :
						 R7out ? BusMuxin_R7 :
						 R8out ? BusMuxin_R8 :
						 R9out ? BusMuxin_R9 :
						 R10out ? BusMuxin_R10 :
						 R11out ? BusMuxin_R11 :
						 R12out ? BusMuxin_R12 :
						 R13out ? BusMuxin_R13 :
						 R14out ? BusMuxin_R14 :
						 R15out ? BusMuxin_R15 :
						 HIout ? BusMuxin_HI :
						 LOout ? BusMuxin_LO :
						 ZHIout ? BusMuxin_Zhi :
						 ZLOout ? BusMuxin_Zlo :
						 PCout ? BusMuxin_PC :
						 MDRout ? BusMuxin_MDR :
						 InPortout ? BusMuxin_InPort :
						 Cout ? C_sign_extended : 
						 32'b0;
						 
endmodule
