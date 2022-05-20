module ALU(output reg[31:0] Output, input [31:0] A, input [31:0] B, input [31:0] C, input ADD, input SUB, input ADDu, input SUBu,
 input MUL, input DIV, input AND, input OR, input XOR, input NOR, input SRL, input SLL, input SRA, input SLA, input ALU_Enable);
	reg[31:0] in_value_add, in_value_addu, in_value_sub, in_value_subu, in_value_and, in_value_or, in_value_xor, in_value_nor, in_value_mul, in_value_div;
	reg[31:0] in_value_shift_right_logical, in_value_shift_left_logical, in_value_shift_right_arithemtic, in_value_shift_left_arithmetic;
	// A is rs and B is rt, the registers in instruction.
	ADD add(in_value_add, A, B);
	ADDu addu(in_value_addu, A, B);
	SUB sub(in_value_sub, A, B);
	SUBu subu(in_value_subu, A, B);
	AND andd(in_value_and, A, B);
	OR orr(in_value_or, A, B);
	XOR xorr(in_value_xor, A, B);
	NOR norr(in_value_nor, A, B);
	MUL mul(in_value_mul, A, B);
	DIV div(in_value_div, A, B);
	ShifterRightLogical shifterrightlogical(in_value_shift_right_logical, B, C);
	ShifterLeftLogical shifterleftlogical(in_value_shift_left_logical, B, C);
	ShifterRightArithmetic shifterrightarithmetic(in_value_shift_right_arithmetic, B, C);
	ShifterLeftArtithmetic shifterleftarithmetic(in_value_shift_left_arithmetic, B, C);
	
	always @(ALU_Enable)
	begin
	if (ALU_Enable)
	begin
	if (ADD) Output = in_value_add;
	else if (ADDu) Output = in_value_addu;
	else if (SUB) Output = in_value_sub;
	else if (SUBu) Output = in_value_subu;
	else if (MUL) Output = in_value_mul;
	else if (DIV) Output = in_value_div;
	else if (AND) Output = in_value_and;
	else if (OR) Output = in_value_or;
	else if (XOR) Output = in_value_xor;
	else if (NOR) Output = in_value_nor;
	else if (SRL) Output = in_value_shift_right_logical;
	else if (SLL) Output = in_value_shift_left_logical;
	else if (SRA) Output = in_value_shift_right_arithmetic;
	else if (SLA) Output = in_value_shift_left_arithmetic;
	end
	else
	begin
	Output = 32'b0;
	end
	end
endmodule
