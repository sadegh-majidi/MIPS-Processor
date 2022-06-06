module cache#(parameter n = 13)(input read, input write, input clk, output reg[1023:0] load_data, input[1023:0] write_data, input[31:0] load_address, input[31:0] write_address, 
output reg hit, output reg ready, output reg[7:0] mem_data_in[0:3], input [7:0] mem_data_out[0:3], output reg mem_write_en);
reg[31:0] n_of_blocks;
initial begin
n_of_blocks = 1 << (n-7);
end
reg [1023:0] memory [n_of_blocks-1:0];
// each block has 32 words. each word has 32 bits. => each block has 1024 bits = 256 words. cache has 2**(n-7) blocks. default is 2**(13-5) = 64 blocks 
reg valid[n_of_blocks-1:0]; // valid bits
reg dirty[n_of_blocks-1:0]; // dirty bits

integer counter = 4;
integer d_counter = 5;
reg ram_data_ready;
reg dirty_replace_ok;


integer i;
initial begin
for ( i = 0; i < n_of_blocks; i = i+1) begin
valid[i] = 1'b0;
dirty[i] = 1'b0;
memory[i] = 1024'bz;
end
ram_data_ready = 1'b0;
dirty_replace_ok = 1'b0;
end


always @(posedge clk) begin // p


if (counter == 0) begin // i

if (d_counter == 0) begin // j

if (read) begin // h
if (valid[load_address[n-1:n-6]] == 1'b0) // r
begin // r

	if (dirty[load_address[n-1:n-6]] == 1'b1) begin
	if (dirty_replace_ok == 1'b0) begin
	mem_write_en = 1'b1;
	mem_data_in[3] = memory[load_address[n-1:n-6]][1023:768];
	mem_data_in[2] = memory[load_address[n-1:n-6]][767:512];
	mem_data_in[1] = memory[load_address[n-1:n-6]][511:256];
	mem_data_in[0] = memory[load_address[n-1:n-6]][256:0];
	d_counter = 1;
	end
	end
	
	if (ram_data_ready) begin // m
	memory[load_address[n-1:n-6]][1023:768] = mem_data_out[3];
	memory[load_address[n-1:n-6]][767:512] = mem_data_out[2];
	memory[load_address[n-1:n-6]][511:256] = mem_data_out[1];
	memory[load_address[n-1:n-6]][256:0] = mem_data_out[0];
	valid[load_address[n-1:n-6]] = 1'b1;
	dirty[load_address[n-1:n-6]] = 1'b0;
	hit = 1'b1;
	ready = 1'b1;
	load_data = memory[load_address[n-1:n-6]];
	ram_data_ready = 1'b0;
	dirty_replace_ok = 1'b0;
	end // m
	else begin // m
	ready = 1'b0;
	hit = 1'b0;
	load_data = 1024'bz;
	counter = 1;
	end // m
	
end // r
else begin // r
	ready = 1'b1;
	hit = 1'b1;
	load_data = memory[load_address[n-1:n-6]];
end // r
end // h
else if (write) begin // h
	memory[load_address[n-1:n-6]] = load_data;
	dirty[load_address[n-1:n-6]] = 1'b1;
end // h

end // j
else begin // j
d_counter = d_counter + 1;
if (d_counter == 2) begin
mem_write_en = 1'b0;
end
if (d_counter == 6) begin
dirty_replace_ok = 1'b1;
d_counter = 0;
end
end // j

end // i
else begin  // i
counter = counter + 1;
if (counter == 5) begin
counter = 0;
ram_data_ready = 1'b1;
end
end // i
end // p
endmodule
