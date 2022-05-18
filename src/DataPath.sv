module DataPath(rs_num, rt_num, rd_num, sh_mount, opcode, func);
wire [31:0] rs_data, rt_data;
wire [31:0] output_data; // this is output_data. It is conceptually equal to rd_data if we have R type instruction, and it is equal to rt_data if we have I type instruction.
input [4:0] rs_num, rt_num, rd_num, sh_mount;
input [5:0] opcode;
input [5:0] func;
wire ADD, SUB, MUL, DIV, AND, OR, XOR, NOR, ALU_Enable;
ALU alu(.Output(output_data), .A(rs_data), .B(rt_data), .ADD(ADD), .SUB(SUB), .MUL(MUL), .DIV(DIV), .AND(AND), .OR(OR), .XOR(XOR), .NOR(NOR), .ALU_Enable(ALU_Enable));
Decoder opcode_decoder(opcode, Enable, Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10, Op11, Op12, Op13, Op14, Op15, Op16, Op17, Op18, Op19, Op20, Op21, Op22, Op23, Op24, Op25, Op26, Op27, Op28, Op29, Op30, Op31, Op32);
regfile registers(.rs_data(rs_data), .rt_data(rt_data), .rs_num(rs_num), .rt_num(rt_num), .rd_num(rd_num), .rd_data(rd_data), .rd_we(rd_we), .clk(clk), .rst_b(rst_b), .halted(halted));
endmodule
