
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

//
// adding these
wire [31:0] pc_input;
DataPath datapath(.rs_num(inst[25:21]), .rt_num(inst[20:16]), .rd_num(inst[15:11]), .sh_mount(inst[10:6]), .opcode(inst[31:26]), .func(inst[5:0]), .imm(inst[15:0]), .pc_value(pc_input));
PC pc(inst_addr, pc_input, clk, rst_b);
//

endmodule
