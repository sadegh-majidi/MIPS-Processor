module PC(inst_addr, pc_input, clk, rst_b);
output reg [31:0] instr_addr;
input [31:0] pc_input;
input clk, rst_b;
always @(posedge clk)
begin
	instr_addr = pc_input;
end
always @(negedge rst_b)
begin
	instr_addr = 32'b0;
end
endmodule;
