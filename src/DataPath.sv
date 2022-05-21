module DataPath(rs_num, rt_num, rd_num, sh_mount, opcode, func, imm, address, pc_value, clk, rst_b, halted, previous_pc_value);
input [31:0] previous_pc_value;
output [31:0] pc_value;
wire [31:0] rs_data, rt_data;
wire [31:0] reg_data_to_write;
input [15:0] imm;
wire [31:0] output_data; // this is output_data. It is conceptually equal to rd_data if we have R type instruction, and it is equal to rt_data if we have I type instruction.
input [4:0] rs_num, rt_num, rd_num, sh_mount;
input [25:0] address;
wire [4:0] reg_num_to_write;
input [5:0] opcode;
input [5:0] func;
wire [31:0] A, B, C;
wire Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10, Op11, Op12, Op13, Op14, Op15, Op16, Op17, Op18, Op19, Op20, Op21, Op22, Op23, Op24, Op25, Op26, Op27, Op28, Op29, Op30, Op31, Op32;
wire Fu1, Fu2, Fu3, Fu4, Fu5, Fu6, Fu7, Fu8, Fu9, Fu10, Fu11, Fu12, Fu13, Fu14, Fu15, Fu16, Fu17, Fu18, Fu19, Fu20, Fu21, Fu22, Fu23, Fu24, Fu25, Fu26, Fu27, Fu28, Fu29, Fu30, Fu31, Fu32;
wire ADD, ADDu, SUB, SUBu, MUL, DIV, AND, OR, XOR, NOR, SRL, SLL, SRA, SLA, ALU_Enable;
wire Select_For_Multiplxr_A, Select_For_Multiplxr_C;
wire Select_For_Multiplxr_B1, Select_For_Multiplxr_B0;
wire L_rs_rt, E_rst_rt, G_rs_rt, N_rs_rt, L_rs_zero, E_rs_zero, G_rs_zero, N_rs_zero;
wire rd_we;
input clk, rst_b, halted;

assign XOR = Fu1 & Op2 | Op20;
assign SLL = (Fu2 | Fu3) & Op2; // considers both SLL and SLLv
assign SRL = (Fu4 & Op2) | (Fu6 & Op2);
assign SUB = Fu5 & Op2;
assign SUBu = Fu9 & Op2;
assign OR = (Fu10 & Op2) | Op21;
assign NOR = Fu11 & Op2;
assign ADDu = Fu12 & Op2 | Op19;
assign MUL = Fu13 & Op2;
assign DIV = Fu14 & Op2;
assign AND = (Fu15 & Op2) | Op8;
assign ADD = (Fu16 & Op2) | Op17 | Op3 | Op22 | Op23 | Op24 | Op25 | Op26;
assign SRA = Fu18 & Op2;

wire write_into_rt, write_into_rd, write_into_pc;
assign write_into_rt = Op17 | Op19 | Op8 | Op20 | Op21 | Op9; // doubt Op9
assign write_into_rd = Op2 & ~Fu8 & ~Fu17;
assign write_into_pc = Op2 & Fu17 | Op4 | Op18 | Op3 & E_rst_rt | Op22 | N_rs_rt & Op6 & (L_rs_zero | E_rs_zero) | Op23 & G_rs_zero | Op24 & (G_rs_zero | E_rs_zero); 
OutputHandler outputhandler(write_into_rt, write_into_rd, write_into_pc, pc_value, rd_num, rt_num, reg_num, reg_data_to_write, output_data, rd_we, clk);
wire sgn_imm;
wire [31:0] sgnextend_imm_00, sgnextend_imm;
assign sgn_imm = imm[15];
assign sgnextend_imm = {sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, imm};
assign sgnextend_imm_00 = {sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, sgn_imm, imm, 1'b0, 1'b0};

ALU alu(.Output(output_data), .A(A), .B(B), .C(C), .ADD(ADD), .SUB(SUB), .ADDu(ADDu), .SUBu(SUBu), .MUL(MUL), .DIV(DIV), .AND(AND), .OR(OR), .XOR(XOR), .NOR(NOR), .SRL(SRL),  .SLL(SLL), .SRA(SRA), .SLA(SLA), .ALU_Enable(ALU_Enable));
Decoder opcode_decoder(opcode, Enable, Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10, Op11, Op12, Op13, Op14, Op15, Op16, Op17, Op18, Op19, Op20, Op21, Op22, Op23, Op24, Op25, Op26, Op27, Op28, Op29, Op30, Op31, Op32);
Decoder func_decoder(func, Enable, Fu1, Fu2, Fu3, Fu4, Fu5, Fu6, Fu7, Fu8, Fu9, Fu10, Fu11, Fu12, Fu13, Fu14, Fu15, Fu16, Fu17, Fu18, Fu19, Fu20, Fu21, Fu22, Fu23, Fu24, Fu25, Fu26, Fu27, Fu28, Fu29, Fu30, Fu31, Fu32);
regfile registers(.rs_data(rs_data), .rt_data(rt_data), .rs_num(rs_num), .rt_num(rt_num), .rd_num(reg_num_to_write), .rd_data(reg_data_to_write), .rd_we(rd_we), .clk(clk), .rst_b(rst_b), .halted(halted));
ORsix1bit orsix1bit1(Select_For_Multiplxr_A, Op3, Op22, Op6, Op23, Op24, 1'b0); // Select For Multiplexer for A input of ALU
ORsix1bit orsix1bit2(Select_For_Multiplxr_C, Fu2, Fu4, Fu18, 1'b0, 1'b0, 1'b0); // Select For Multiplexer for C input of ALU
ORsix1bit orsix1bit3(Select_For_Multiplxr_B0, Op3, Op22, Op6, Op23, Op24, Op2); // Select For Multiplexer for B1 input of ALU
ORsix1bit orsix1bit4(Select_For_Multiplxr_B1, Op8, Op20, Op21, 1'b0, 1'b0, Op2); // Select For Multiplexer for B0 input of ALU
Multiplexer2to1 multiplexer2to1forA(A, rs_data, PC, Select_For_Multiplxr_A);
Multiplexer2to1 multiplexer2to1forC(C, rs_data, sh_mount, Select_For_Multiplxr_C);
Multiplexer4to2 multiplexer4to2forB(.k(B), .i3(rt_data), .i2({16'b0, imm}), .i1(sgnextend_imm_00), .i0(sgnextend_imm), .Select1(Select_For_Multiplxr_B1), .Select0(Select_For_Multiplxr_B0));
Comparator comparator(rs_data, rt_data, L_rs_rt, E_rst_rt, G_rs_rt, N_rs_rt);
Comparator comparator_rs_and_zero(rs_data, 32'b0, L_rs_zero, E_rs_zero, G_rs_zero, N_rs_zero);
endmodule
