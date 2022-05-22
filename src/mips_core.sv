
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
    output  [31:0] inst_addr;
    input   [31:0] inst;
    output  [31:0] mem_addr;
    input   [7:0]  mem_data_out[0:3];
    output  [7:0]  mem_data_in[0:3];
    output         mem_write_en;
    output reg     halted;
    input          clk;
    input          rst_b;


	wire [5:0]  opcode;
	wire [4:0]  rs;
	wire [4:0]  rt;
	wire [4:0]  rd;
	wire [15:0] imm;
	wire [4:0]  sh_amount;
	wire [31:0] jaddr;
	wire [31:0] seimm;
    wire [5:0] func;

    // todo: add always for reset


	assign opcode       = inst[31:26];
	assign rs_num       = inst[25:21];
	assign rt_num       = inst[20:16];
	assign rd_num       = inst[15:11];
	assign imm          = inst[15:0];
	assign sh_amount    = inst[10:6];
	assign func         = inst[5:0];
	assign jaddr        = {pc[31:28], inst[25:0], {2{1'b0}}};
	assign seimm 	    = {{16{inst[15]}}, inst[15:0]};


    wire [31:0] rs_data, rt_data;
    reg [31:0] rd_data_output, alu_out_data;
    reg rd_we, alu_ready;

    control_unit control_unit_ (
        // input
        //  inst
        .opcode(opcode),
        .func(func),
        .imm(imm),
        .sh_amount(sh_amount),
        .jaddr(jaddr),
        .seimm(seimm),
        //  data 
        .rs_data(rs_data),
        .rt_data(rt_data),
        .alu_out_data(alu_out_data),
        .alu_ready(alu_ready)
        // out
        //  alu
        .rd_we(rd_we),
        .A(A),
        .B(B),
        .aluctl(aluctl)
        //  reg 
        .rd_data_output(rd_data_output),
        .halted_signal(halted)
    );


    regfile regfile_1 (
        .rs_data(rs_data),
        .rt_data(rt_data),
        .rs_num(rs_num),
        .rt_num(rt_num),
        .rd_num(rd_num),
        .rd_data(rd_data_output),
        // todo: rd_we
        .rd_we(rd_we),
        .clk(clk),
        .rst_b(rst_b),
        .halted(halted)
    );


    alu alu_ (
        .aluctl(aluctl),
        .A(A),
        .B(B),
        .C(alu_out_data),
        .ready(alu_ready),
    );


endmodule
