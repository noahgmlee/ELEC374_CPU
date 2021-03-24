module Multiplier (input[31:0] M, Q, output[63:0] result);
    reg[63:0] prod;
	 reg[2:0] bit_pair_recode;
	 assign result = prod;
    integer i;
    always @(*) begin
        prod = 0;
        for (i = 0; i < 32; i = i + 2) begin
            if (i == 0) begin
					bit_pair_recode = {Q[i+1], Q[i], 1'b0};
				end else begin
					bit_pair_recode = {Q[i+1], Q[i], Q[i-1]};
				end
				
				if (bit_pair_recode == 3'b001) begin
					prod = prod + (M << i);
				end else if (bit_pair_recode == 3'b010) begin
					prod = prod + (M << i);
				end else if (bit_pair_recode == 3'b011) begin
					prod = prod + (M << i + 1);
				end else if (bit_pair_recode == 3'b100) begin
					prod = prod + ((-M) << i + 1);
				end else if (bit_pair_recode == 3'b101) begin
					prod = prod + ((-M) << i);
				end else if (bit_pair_recode == 3'b110) begin
					prod = prod + ((-M) << i);
				end else begin
					prod = prod;
				end
/*			
				case (bit_pair_recode)
					3'b001 : begin
								prod <= prod + (M << i);
								end
					3'b010 :	begin
								prod <= prod + (M << i);
								end
					3'b011 :	begin
								prod <= prod + (M << i + 1);
								end
					3'b100 : begin 
								prod <= prod + ((-M) << i + 1);
								end
					3'b101 : begin
								prod <= prod + ((-M) << i);
								end
					3'b110 :	begin
								prod <= prod + ((-M) << i);
								end
					default : begin
									prod <= prod;
								 end//do nothing
				endcase
*/
			end		
		end
			
endmodule
