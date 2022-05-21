module Multiplexer2to1(k, i1, i0, Select);
	input Select;
	input wire[31:0] i1, i0;
	output reg[31:0] k;
	always @(i1 or i0 or Select)
	begin
	if (Select)
		k = i1;
	else
		k = i0;
	end
endmodule
