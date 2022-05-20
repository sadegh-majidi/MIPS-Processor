module DataPath(rs_num, rt_num, rd_num, sh_mount, opcode, func, imm, pc_value);
wire [31:0] rs_data, rt_data;
output reg [31:0] pc_value;
input [15:0] imm;
wire [31:0] output_data; // this is output_data. It is conceptually equal to rd_data if we have R type instruction, and it is equal to rt_data if we have I type instruction.
input [4:0] rs_num, rt_num, rd_num, sh_mount;
input [5:0] opcode;
input [5:0] func;
wire [31:0] A, B, C;
wire Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10, Op11, Op12, Op13, Op14, Op15, Op16, Op17, Op18, Op19, Op20, Op21, Op22, Op23, Op24, Op25, Op26, Op27, Op28, Op29, Op30, Op31, Op32;
wire Fu1, Fu2, Fu3, Fu4, Fu5, Fu6, Fu7, Fu8, Fu9, Fu10, Fu11, Fu12, Fu13, Fu14, Fu15, Fu16, Fu17, Fu18, Fu19, Fu20, Fu21, Fu22, Fu23, Fu24, Fu25, Fu26, Fu27, Fu28, Fu29, Fu30, Fu31, Fu32;
wire ADD, ADDu, SUB, SUBu, MUL, DIV, AND, OR, XOR, NOR, SRL, SLL, SRA, SLA, ALU_Enable;
wire Select_For_Multiplxr_A, Select_For_Multiplxr_C;
wire L_rs_rt, E_rst_rt, G_rs_rt, N_rs_rt, L_rs_zero, E_rst_zero, G_rs_zero, N_rs_zero;

assign XOR = Fu1 & Op2 | Op20;
assign SLL = (Fu2 | Fu3) & Op2; // considers both SLL and SLLv
assign SRL = Fu4 & Op2;
assign SUB = Fu5 & Op2;
assign SRL = Fu6 & Op2;
assign SUbu = Fu9 & Op2;
assign OR = (Fu10 & Op2) | Op21;
assign NOR = Fu11 & Op2;
assign ADDu = Fu12 & Op2 | Op19;
assign MUL = Fu13 & Op2;
assign DIV = Fu14 & Op2;
assign AND = (Fu15 & Op2) | Op8;
assign ADD = (Fu16 & Op2) | Op17 | Op3 | Op22 | Op23 | Op24 | Op25 | Op26;
assign SRA = Fu18 & Op2;

ALU alu(.Output(output_data), .A(A), .B(B), .C(C), .ADD(ADD), .SUB(SUB), .ADDu(ADDu), .SUBu(SUBu), .MUL(MUL), .DIV(DIV), .AND(AND), .OR(OR), .XOR(XOR), .NOR(NOR), .SRL(SRL),  .SLL(SLL), .SRA(SRA), .SLA(SLA), .ALU_Enable(ALU_Enable));
Decoder opcode_decoder(opcode, Enable, Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10, Op11, Op12, Op13, Op14, Op15, Op16, Op17, Op18, Op19, Op20, Op21, Op22, Op23, Op24, Op25, Op26, Op27, Op28, Op29, Op30, Op31, Op32);
Decoder func_decoder(func, Enable, Fu1, Fu2, Fu3, Fu4, Fu5, Fu6, Fu7, Fu8, Fu9, Fu10, Fu11, Fu12, Fu13, Fu14, Fu15, Fu16, Fu17, Fu18, Fu19, Fu20, Fu21, Fu22, Fu23, Fu24, Fu25, Fu26, Fu27, Fu28, Fu29, Fu30, Fu31, Fu32);
regfile registers(.rs_data(rs_data), .rt_data(rt_data), .rs_num(rs_num), .rt_num(rt_num), .rd_num(rd_num), .rd_data(rd_data), .rd_we(rd_we), .clk(clk), .rst_b(rst_b), .halted(halted));
ORsix1bit orsix1bit1(Select_For_Multiplxr_A, Op3, Op22, Op6, Op23, Op24, 1'b0); // Select For Multiplexer for A input of ALU
ORsix1bit orsix1bit2(Select_For_Multiplxr_C, Fu2, Fu4, Fu18, 1'b0, 1'b0, 1'b0); // Select For Multiplexer for C input of ALU
Multiplexer2to1 multiplexer2to1forA(A, rs_data, PC, Select_For_Multiplxr_A);
Multiplexer2to1 multiplexer2to1forC(C, rs_data, sh_mount, Select_For_Multiplxr_C);
Multiplexer4to2 multiplexer4to2forB(.k(B), .i3({14'b0, imm, 2'b0}), .i2({14'b0, imm, 2'b0}), .i1({16'b0, imm}), .i0(rt_data), .Select1(Select_For_Multiplxr_A), .Select0(Op2));
Comparator comparator(rs_data, rt_data, L_rs_rt, E_rst_rt, G_rs_rt, N_rs_rt);
Comparator comparator_rs_and_zero(rs_data, 32'b0, L_rs_zero, E_rst_zero, G_rs_zero, N_rs_zero);
endmodule
