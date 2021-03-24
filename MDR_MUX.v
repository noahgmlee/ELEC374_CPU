module MDR_Mux (input Read, input [31:0] Busout, Mdatain, output [31:0] MDMux_out);

assign MDMux_out = Read ? Mdatain : Busout;

endmodule
