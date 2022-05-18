module ALU(output reg[31:0] Output, input [31:0] A, input [31:0] B, input ADD, input SUB, input MUL, input DIV, input AND, input OR, input XOR, input NOR, input ALU_Enable);
	reg[31:0] in_value_add, in_value_sub, in_value_and, in_value_orr, in_value_xor, in_value_nor, in_value_mul, in_value_div;
	ADD add(in_value_add, A, B);
	SUB sub(in_value_sub, A, B);
	AND andd(in_value_and, A, B);
	OR orr(in_value_orr, A, B);
	XOR xorr(in_value_xor, A, B);
	NOR norr(in_value_nor, A, B);
	always @(ALU_Enable)
	begin
	if (ALU_Enable)
	begin
	if (ADD) Output = in_value_add;
	else if (SUB) Output = in_value_sub;
	else if (MUL) Output = in_value_mul;
	else if (DIV) Output = in_value_div;
	else if (AND) Output = in_value_and;
	else if (OR) Output = in_value_or;
	else if (XOR) Output = in_value_xor;
	else if (NOR) Output = in_value_nor;
	end
	else
	begin
	Output = 32'b0;
	end
	end
endmodule
