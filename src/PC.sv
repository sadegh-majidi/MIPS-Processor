module PC(inst_addr, pc_input, clk, rst_b);
output reg [31:0] inst_addr;
input [31:0] pc_input;
input clk, rst_b;
always @(posedge clk)
begin
	inst_addr = pc_input;
end
always @(negedge rst_b)
begin
	inst_addr = 32'b0;
end
endmodule
