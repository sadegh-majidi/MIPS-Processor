module ShifterRightArithmetic(output reg signed[31:0] Output, input signed[31:0] A, input [31:0] B);
	always @(A or B)
	begin
	Output = A >>> B[4:0];
	end
endmodule
