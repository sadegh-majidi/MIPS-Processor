module SUBu(output reg [31:0] Output, input [31:0] A, input [31:0] B);
	always @(A or B)
	begin
	Output = A - B;
	end
endmodule
