module OutputHandler(write_into_rt, write_into_rd, write_into_pc, pc_value, rd_num, rt_num, reg_num_to_write, reg_data_to_write, output_data, rd_we);
input write_into_rt, write_into_rd, write_into_pc;
input [4:0] rd_num, rt_num;
output reg rd_we;
output reg [31:0] pc_value;
input [31:0] output_data; 
output reg [4:0] reg_num_to_write;
output reg [31:0] reg_data_to_write; // it is written in either rs or rt. To write in pc, use the other variable.
always@(*)
begin
if (write_into_rt)
begin
reg_data_to_write = rt_num;
reg_data_to_write = output_data;
rd_we = 1'b1;
// pc_value = previous value + 4 so that pc reads the next instruction
end
else if (write_into_rd)
begin
reg_data_to_write = rd_num;
reg_data_to_write = output_data;
rd_we = 1'b1;
// pc_value = previous value + 4 so that pc reads the next instruction
end
else if (write_into_pc)
begin
pc_value = output_data;
rd_we = 1'b0;
end
else
begin
rd_we = 1'b0;
end
end
endmodule

