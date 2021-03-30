`timescale 1ns/1ns
module control_unit (
output reg 		Gra, Grb, Grc, Rin, Rout,
					HIin, LOin, CONin, PCin, IRin, Yin, Zin, MARin, MDRin, OUTPort_in, Cout, BAout,
					PCout, MDRout, Zhighout, Zlowout, HIout, LOout, InPortout, IncPC,
					Read, Write, Clear, Run,
input [31:0]	IR,
input 			Clock, Reset, Stop, CON_FF);

parameter 		Reset_state= 6'b000000, fetch0 = 6'b000001, fetch1 = 6'b000010, fetch2= 6'b000011, 
					ALUbasic3 = 6'b000100, ALUbasic4 = 6'b000101, ALUbasic5 = 6'b000110, ALUimm3 = 6'b000111, 
					ALUimm4 = 6'b001000, ALUimm5 = 6'b001001, muldiv3 6'b001010, muldiv4 = 6'b001011, muldiv5 = 6'b001100, 
					muldiv6 = 6'b001101, ld3 = 6'b001110, ld4 = 6'b001111, ld5 = 6'b010000, ld6 = 6'b010001, ld7 = 6'b010010, 
					ldimm3 = 6'b010011, ldimm4 = 6'b010100, ldimm5 = 6'b010101, st3 = 6'b010110, st4 = 6'b010111, 
					st5 = 6'b011000, st6 = 6'b011001, st7 = 6'b011010, br3 = 6'b011011, br4 = 6'b011100, br5 = 6'b011101, 
					br6 = 6'b011110, jal3 = 6'b011111, jal4 = 6'b100000, jr3 = 6'b100001, mfhi3 = 6'b100010, 
					mflo3 = 6'b100011, in3 = 6'b100100, out3 = 6'b100101, nop3 = 6'b100110, halt3 = 6'b100111;

parameter		Load = 5'b00000, Load_imm = 5'b00001, Store = 5'b00010, Addition = 5'b00011, Subtraction = 5'b00100,
					SHR = 5'b00101, SHL = 5'b00110, ROR = 5'b00111, ROL = 5'b01000, AND = 5'b01001, OR = 5'b01010,
					Add_imm = 5'b01011, AND_imm = 5'b01100, OR_imm = 5'b01101, Multiply = 5'b01110, Divide = 5'b01111,
					Negate = 5'b10000, NOT = 5'b10001, Branch = 5'b10010, JR = 5'b10011, JAL = 5'b10100, IN = 5'b10101,
					OUT = 5'b10110, MFHI = 5'b10111, MFLO = 5'b11000, NOP = 5'b11001, HALT = 5'b11010;	
					
reg [5:0] 		Present_state = Reset_state;

always @(posedge Clock, posedge Reset) begin
	if (Reset == 1'b1) Present_state = Reset_state;
	else if (Run == 1'b1)
		case(Present_state)
			Reset_state		:	Present_state = fetch0;
			fetch0			:	Present_state = fetch1;
			fetch1			:	Present_state = fetch2;
			fetch2			:	begin
										case(IR[31:27])
											Addition, Subtraction, AND, OR, SHR, SHL, ROR, ROL, Negate, NOT	: 
												Present_state = ALUbasic3;
											ADD_imm, AND_imm, OR_imm	: 
												Present_state = ALUimm3;
											Multiply, Divide	:
												Present_state = muldiv3;
											Load	:
												Present_state = ld3;
											Load_imm	:
												Present_state = ldimm3;
											Store	:
												Present_state = st3;
											Branch	:
												Present_state = br3;
											JAL	:
												Present_state = jal3;
											JR	:
												Present_state = jr3;
											MFHI	:
												Present_state = mfhi3;
											MFLO	:
												Present_state = mflo3;
											IN	:
												Present_state = in3;
											OUT	:
												Present_state = out3;
											NOP	:
												Present_state = nop3;
											HALT	:
												Present_state = halt3;
										
										endcase
									end
				
				ALUbasic3	:  Present_state = ALUbasic4;
				ALUbasic4	:  Present_state = ALUbasic5;
				ALUbasic5	:  Present_state = fetch0;
				
				ALUimm3		:  Present_state = ALUimm4;
				ALUimm4		:  Present_state = ALUimm5;
				ALUimm5		:  Present_state = fetch0;
				
				muldiv3		:  Present_state = muldiv4;
				muldiv4		:  Present_state = muldiv5;
				muldiv5		:	Present_state = muldiv6;
				muldiv6		:  Present_state = fetch0;
				
				ld3			:	Present_state = ld4;
				ld4			:	Present_state = ld5;
				ld5			:	Present_state = ld6;
				ld6			:	Present_state = ld7;
				ld7			:	Present_state = fetch0;
				
				ldimm3		:  Present_state = ldimm4;
				ldimm4		:  Present_state = ldimm5;
				ldimm5		:  Present_state = fetch0;
				
				st3			:	Present_state = st4;
				st4			:	Present_state = st5;
				st5			:	Present_state = st6;						
				st6			:	Present_state = st7;							
				st7			:	Present_state = fetch0;		

				br3			:  Present_state = br4;
				br4			:  Present_state = br5;
				br5			:  Present_state = br6;
				br6			:  Present_state = fetch0;
				
				jal3			:  Present_state = jal4;
				jal4			:  Present_state = fetch0;
				
				jr3			:  Present_state = fetch0;
				mfhi3			:  Present_state = fetch0;
				mflo3			:  Present_state = fetch0;
				in3			:  Present_state = fetch0;		
				out3			:  Present_state = fetch0;
				nop3			:  Present_state = fetch0;
				halt3			:  Present_state = fetch0;
		endcase
	end
end

always @(Present_state) begin
	case (Present_state)
		Reset_state : begin
			Gra <= 0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0;
			HIin <= 0; LOin <= 0; CONin <= 0; PCin <= 0; IRin <= 0; Yin <= 0; Zin <= 0; MARin <= 0; 
			MDRin <= 0; OUTPort_in <=0; Cou <= 0; BAout <= 0; PCout <= 0; MDRout <= 0; Zhighout <= 0; 
			Zlowout <= 0; HIout <= 0; LOout <= 0; InPortout <= 0; IncPC <= 0; Read <= 0; Write <= 0; 
			Clear <= 1; Run <= 1;
		end
		fetch0 : begin
			PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
			#25 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
		end
		fetch1 : begin
			Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
			#25 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
		end
		fetch2 : begin
			MDRout <= 1; IRin <= 1;
			#25 MDRout <= 0; IRin <= 0;
		end
		/*
		todo
		*/
	endcase
end
				

