module DIV(output reg signed[31:0] Output, input signed[31:0] A, input signed[31:0] B);
	always @(A or B)
	begin
	Output = A / B;
	end
endmodule
