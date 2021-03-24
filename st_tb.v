`timescale 1ns/1ns
module st_tb;

reg PCout, Zlowout, Zhighout, MDRout;// add any other signals to see in your simulation
reg MARin, Zin, PCin, MDRin, IRin, Yin;
reg IncPC, Read, Write; 
reg Clock, CONin, Gra, Grb, Grc, Rin, Rout, BAout, Cout;
wire [31:0] Busout, Z_low, Z_high, R1out, R0out;
	
parameter	T0 = 4'b0000,
				T1 = 4'b0001,
				T2 = 4'b0010,
				T3 = 4'b0011,
				T4 = 4'b0100,
				T5 = 4'b0101,
				T6 = 4'b0110,
				T7 = 4'b0111,
				T8 = 4'b1000;
					
reg [3:0] Present_state = T0;
	
Datapath DUT (PCout, Zlowout, Zhighout, MDRout, MARin, Zin, PCin, MDRin, IRin, Yin, IncPC, 
					  Read, Write, Clock, CONin, Gra, Grb, Grc, Rin, Rout, BAout, Cout,
					  Busout, Z_low, Z_high, R1out, R0out);
	
initial 
	begin
		Clock = 0;
		forever #10 Clock = ~ Clock;
	end
		
always @(posedge Clock)//finite state machine; if clock rising-edge
	begin
		case (Present_state)//#40 was added in week 5, this will cover later time delays
			T0				:	#40	Present_state = T1;
			T1				:	#40	Present_state = T2;
			T2				:	#40	Present_state = T3;
			T3				:	#40	Present_state = T4;
			T4				:	#40	Present_state = T5;
			T5				:	#40	Present_state = T6;
			T6				:	#40	Present_state = T7;
			T7				:  #40	Present_state = T8;
		endcase
	end
	
always @(Present_state)// do the required job in each state
	begin
		case (Present_state)              //assert the required signals in each clock cycle
			T0: begin			//see if you need to de-assertthese signals
				PCout<= 1; 
				MARin <= 1; 
				IncPC <= 1; 
				Zin <= 1;
				Zlowout <= 0;
				Zhighout <= 0;
				MDRout <= 0;
				Cout <= 0;
				Write <= 0;
				#25 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
			end
			T1: begin
				Zlowout<= 1; 
				PCin <= 1; 
				Read <= 1;
				MDRin <= 1; 
				#25 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
			end
			T2: begin
				MDRout<= 1; 
				IRin <= 1;
				#25 MDRout <= 0; IRin <= 0;
			end
			T3: begin
				Grb <= 1;
				BAout <= 1;
				Yin <= 1;
				#25 Grb <= 0; BAout <= 0; Yin <= 0;
			end
			T4: begin
				Zin <= 1;
				Cout <= 1;
				#25 Cout <= 0; Zin <= 0;
			end
			T5: begin
				Zlowout <= 1;
				MARin <= 1;
				#25 MARin <= 0; Zlowout <= 0;
			end
			T6: begin
				Gra <= 1;
				BAout <= 1;
				MDRin <= 1;
				#25 BAout <= 0; Gra <= 0; MDRin <= 0;
			end
			T7: begin
				Write <= 1;
			end
			T8: begin
				Write <= 0;
				Read <= 1;
			end
	endcase
end
endmodule
