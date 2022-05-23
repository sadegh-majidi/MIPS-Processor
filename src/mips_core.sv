
module mips_core(
    inst_addr,
    inst,
    mem_addr,
    mem_data_out,
    mem_data_in,
    mem_write_en,
    halted,
    clk,
    rst_b
);
    input   [31:0] inst;
    input   [7:0]  mem_data_out[0:3];
    input          clk;
    input          rst_b;

    output reg [31:0] inst_addr;
    output reg[31:0] mem_addr;
    output reg[7:0]  mem_data_in[0:3];
    output reg       mem_write_en;
    output reg     halted;

	wire [5:0]  opcode;
    wire [5:0]  func;
	wire [4:0]  rs_num;
	wire [4:0]  rt_num;
	wire [4:0]  rd_num;
    wire [4:0]  sh_amount;
    wire [15:0] imm;
    wire [31:0] pc_branch;
    wire [27:0] pc_j;
    wire pc_branch_en;
    wire pc_j_en;
    wire [25:0] address_j_format;
    reg  [31:0] tmp_inst_addr;

	assign opcode       = inst[31:26];
	assign func         = inst[5:0];
	assign rs_num       = inst[25:21];
	assign rt_num       = inst[20:16];
	assign rd_num       = inst[15:11];
    assign sh_amount    = inst[10:6];
    assign imm          = inst[15:0];
    assign address_j_format = inst[25:0];


    always @(posedge clk) begin
        if(!rst_b) begin
           inst_addr <= 32'b0;
           tmp_inst_addr <= 32'b0;
        end
        else begin
            if(pc_branch_en == 1'b1) begin
                inst_addr <= inst_addr + pc_branch;
                tmp_inst_addr <= inst_addr + pc_branch;
                $display("in mips BNE pc inst=%b",inst_addr + pc_branch);
            end
            else if(pc_j_en == 1'b1) begin 
                inst_addr <= {inst_addr[31:28], pc_j};
                tmp_inst_addr <= {inst_addr[31:28], pc_j};
                $display("in mips core pc inst=%b",{inst_addr[31:28], pc_j});
            end
            else begin
                  inst_addr <= inst_addr + 32'd4;
                  tmp_inst_addr <= inst_addr + 32'd4;
            end
        end
        $display("clock===== done inst=%b opcode=%b func=%b pc=%b",inst , opcode, func, inst_addr);
    end

    control_unit control_unit_ (
        .clk(clk),
        .rst_b(rst_b),
        .opcode(opcode),
        .func(func),
        .rs_num(rs_num),
        .rt_num(rt_num),
        .rd_num(rd_num),
        .sh_amount(sh_amount),
        .imm(imm),
        .address_j_format(address_j_format),
        .inst_addr(tmp_inst_addr),
        .pc_branch(pc_branch),
        .pc_j(pc_j),
        .pc_branch_en(pc_branch_en),
        .pc_j_en(pc_j_en),
        .mem_data_out(mem_data_out),
        .mem_addr(mem_addr),
        .mem_data_in(mem_data_in),
        .mem_write_en(mem_write_en),
        .halted_signal(halted)
    );
endmodule
