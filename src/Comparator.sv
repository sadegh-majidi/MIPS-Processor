module Comparator(rs, rt, L, E, G, N);
	output reg L, E, G, N; // L = Lower , E = Equal , G = Greater , N = Note Equal
	input wire signed[31:0] rs, rt;
	
	always@(rs or rt)
	begin
		if(rs < rt)
		begin
			L = 1;
			E = 0;
			G = 0;
			N = 1;
		end
		else if (rs == rt)
		begin
			L = 0;
			E = 1;
			G = 0;
			N = 0;
		end
		else 
		begin
			L = 0;
			E = 0;
			G = 1;
			N = 0;
		end
	end
endmodule
