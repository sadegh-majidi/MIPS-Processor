module Multiplexer4to2(k, i3, i2, i1, i0, Select1, Select0);
	input Select1, Select0;
	input wire[31:0] i3, i2, i1, i0;
	output reg[31:0] k;
	always @(i3 or i2 or i1 or i0 or Select1 or Select0)
	begin
	if (Select1 == 1)
	begin
		if (Select0 == 1)
			k = i3;
		else
			k = i2;
	end
	else
	begin
		if (Select0 == 1)
			k = i1;
		else
			k = i0;
	end
	end
endmodule
