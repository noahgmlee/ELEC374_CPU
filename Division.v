module Division (input [31:0] M, Q, output [31:0] result, remainder);

	reg [64:0] AQ;
	reg [32:0] Mtemp, Rem;
	reg [5:0] i;
	
	assign result = AQ[31:0];
	assign remainder = Rem[31:0];
	
	always @ (Q or M) begin
		AQ[64:32] = 0;
		AQ[31:0] = Q;
		Mtemp[31:0] = M;
		Mtemp[32] = M[31];
		
		for (i = 0; i < 32; i = i + 1) begin
			AQ = AQ << 1;
			if (AQ[64] == 0) begin
				AQ[64:32] = AQ[64:32] - Mtemp;
			end else begin
				AQ[64:32] = AQ[64:32] + Mtemp;
			end
			
			if (AQ[64] == 0) begin
				AQ[0] = 1;
			end else begin
				AQ[0] = 0;
			end
		end
		if (AQ[64]) begin
			Rem = AQ[64:32] + Mtemp;
		end else	begin
			Rem = AQ[64:32];
		end
	end
endmodule
		
