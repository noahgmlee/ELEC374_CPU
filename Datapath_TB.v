`timescale 1ns/1ns
module Datapath_TB;

	reg PCout, Zlowout, Zhighout, MDRout;// add any other signals to see in your simulation
	reg MARin, Zin, PCin, MDRin, IRin, Yin;
	reg IncPC, Read; 
	reg Clock;
	reg [15:0] GPRin, GPRout;
	reg [31:0] Mdatain;
	wire [31:0] Busout, Z_low, Z_high;
	
	parameter	Default = 4'b0000,
					Reg_load1a = 4'b0001,
					Reg_load1b = 4'b0010,
					Reg_load2a = 4'b0011,
					Reg_load2b = 4'b0100,
					Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110,
					T0 = 4'b0111, 
					T1 = 4'b1000,
					T2 = 4'b1001, 
					T3 = 4'b1010, 
					T4 = 4'b1011, 
					T5 = 4'b1100;
					//T6 = 4'b1101;
					
	reg [3:0] Present_state = Default;
	
	Datapath DUT (PCout, Zlowout, Zhighout, MDRout, MARin, Zin, PCin, MDRin, IRin, Yin, IncPC, Read, 
					  Clock, GPRin, GPRout, Mdatain, Busout, Z_low, Z_high);
	
	initial 
		begin
			Clock = 0;
			forever #10 Clock = ~ Clock;
		end
	always @(posedge Clock)//finite state machine; if clock rising-edge
		begin
		case (Present_state)//#40 was added in week 5, this will cover later time delays
			Default		:	#40	Present_state = Reg_load1a;
			Reg_load1a	:	#40	Present_state = Reg_load1b;
			Reg_load1b	:	#40	Present_state = Reg_load2a;
			Reg_load2a	:	#40	Present_state = Reg_load2b;
			Reg_load2b	:	#40	Present_state = Reg_load3a;
			Reg_load3a	:	#40	Present_state = Reg_load3b;
			Reg_load3b	:	#40	Present_state = T0;
			T0				:	#40	Present_state = T1;
			T1				:	#40	Present_state = T2;
			T2				:	#40	Present_state = T3;
			T3				:	#40	Present_state = T4;
			T4				:	#40	Present_state = T5;
		//	T5				:	#40	Present_state = T6;
		endcase
	end
	
	always @(Present_state)// do the required job in each state
		begin
		case (Present_state)              //assert the required signals in each clock cycle
			Default: begin 
				PCout <= 0;   
				Zlowout <= 0;   
				Zhighout <= 0;
				MDRout <= 0;   //initialize the signals
				MARin <= 0;   
				Zin <= 0;  
				PCin <=0;  
				MDRin <= 0;   
				IRin  <= 0;  
				Yin <= 0;  
				IncPC <= 0;   
				Read <= 0;  
				GPRin <= 16'b0; 
				GPRout <= 16'b0; 
				Mdatain <= 32'h00000000;
			end
			Reg_load1a: begin 
				Mdatain <= 32'h00000022; 
				Read = 0; 
				MDRin = 0;//the first zero is there for completeness
				#10 Read <= 1;
					 MDRin <= 1;  
				#15 Read <= 0;
					 MDRin <= 0;
			end
			Reg_load1b: begin
				#10 MDRout<= 1; 
					 GPRin <= 4;  
				#15 MDRout<= 0; 
					 GPRin <= 0;     // initialize R2 with the value $22
			end
			Reg_load2a: begin 
				Mdatain <= 32'h00000024;
				#10 Read <= 1; 
					 MDRin <= 1;  
				#15 Read <= 0;
					 MDRin <= 0;
			end
			Reg_load2b: begin
				#10 MDRout<= 1; 
					 GPRin <= 16;  
				#15 MDRout<= 0; 
					 GPRin <= 0;// initialize R4 with the value $24 
			end
			Reg_load3a: begin
				Mdatain <= 32'h00000026;
				#10 Read <= 1; 
					 MDRin <= 1;  
				#15 Read <= 0; 
					 MDRin <= 0;
			end
			Reg_load3b: begin
				#10 MDRout<= 1; 
					 GPRin <= 32;  
				#15 MDRout<= 0; 
					 GPRin <= 0;// initialize R5 with the value $26 
			end
			T0: begin			//see if you need to de-assertthese signals
				PCout<= 1; 
				MARin <= 1; 
				IncPC <= 1; 
				Zin <= 1;
				#25 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
			end
			T1: begin
				Zlowout<= 1; 
				PCin <= 1; 
				Read <= 1;
				MDRin <= 1; 
				#25 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
				Mdatain <= 32'h8A920000;   //opcode //AND is 4A920000
			end
			T2: begin
				MDRout<= 1; 
				IRin <= 1;
				#25 MDRout <= 0; IRin <= 0;
			end
			T3: begin
				GPRout <= 4; 
				Yin <= 1; 
				#25 GPRout <= 0; Yin <= 0;
			end
			T4: begin
				GPRout <= 16; 
				Zin <= 1; 
				#25 GPRout <= 0; Zin <= 0;
			end
			T5: begin
				Zlowout<= 1;
				GPRin <= 32; 
				#25 GPRin <= 0; Zlowout <= 0;
			end
			/*
			//for division and multiplication only
			T6: begin
				Zhighout <= 1;
				#25 Zhighout <= 0;
			end
			*/
		endcase
	end
endmodule
