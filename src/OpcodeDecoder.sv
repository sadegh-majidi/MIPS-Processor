module Decoder(input_instr, Enable,
 Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10, Op11, Op12, Op13, Op14, Op15, Op16, Op17, Op18, Op19, Op20, Op21, Op22, Op23, Op24, Op25, Op26, Op27, Op28, Op29, Op30, Op31, Op32);
	input [5:0] input_instr;
	input Enable;
	output reg Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10, Op11, Op12, Op13, Op14, Op15, Op16, Op17, Op18, Op19, Op20, Op21, Op22, Op23, Op24, Op25, Op26, Op27, Op28, Op29, Op30, Op31, Op32;
	
always @ (Enable, input_instr) 
begin 
 Op1 = 0;
 Op2 = 0;
 Op3 = 0;
 Op4 = 0;
 Op5 = 0;
 Op6 = 0;
 Op7 = 0;
 Op8 = 0;
 Op9 = 0;
 Op10 = 0;
 Op11 = 0;
 Op12 = 0;
 Op13 = 0;
 Op14 = 0;
 Op15 = 0;
 Op16 = 0;
 Op17 = 0;
 Op18 = 0;
 Op19 = 0;
 Op20 = 0;
 Op21 = 0;
 Op22 = 0;
 Op23 = 0;
 Op24 = 0;
 Op25 = 0;
 Op26 = 0;
 Op27 = 0;
 Op28 = 0;
 Op29 = 0;
 Op30 = 0;
 Op31 = 0;
 Op32 = 0; 
if (Enable == 1'b1) 
 begin 
 case (input_instr) 
 6'b100110: Op1 = 1; // Func 100110 XOR #1 R type 
 6'b000000: Op2 = 1; // Func 000000 SLL #2 R type
 6'b000100: Op3 = 1; // Func 000100 SLLV #3 R type    or it can be     Opcode 000100 BEQ #6 I type
 6'b000010: Op4 = 1; // Func 000010 SRL #4 R type    or it can be    Opcode 000010 j #1 J type
 6'b100010: Op5 = 1; // Func 100110 SUB #5 R type 
 6'b000110: Op6 = 1; // Func 000110 SRLV #6 R type    or it can be    Opcode 000110 BLEZ #8 I type
 6'b101010: Op7 = 1; // Func 101010 SLT #7 R type 
 6'b001100: Op8 = 1; // Func 001100 Syscall #8 R type       or it can be    Opcode 001100 ANDi #3 I type
 6'b100011: Op9 = 1; // Func 100011 SUBU #9 R type     or it can be      Opcode 100011 LW #11 I type
 6'b100101: Op10 = 1; // Func 100101 OR #10 R type
 6'b100111: Op11 = 1; // Func 100111 NOR #11 R type 
 6'b100001: Op12 = 1; // Func 100001 ADDu #12 R type
 6'b011000: Op13 = 1; // Func 011000 MULT #13 R type 
 6'b011010: Op14 = 1; // Func 011010 DIV #14 R type
 6'b100100: Op15 = 1; // Func 100100 AND #15 R type 
 6'b100000: Op16 = 1; // Func 100000 ADD #16 R type   or it can be    Opcode 100000 LB #13 I type
 6'b001000: Op17 = 1; // Func 001000 JR #17 R type    or it can be    Opcode 001000 ADDi #1 I type 
 6'b000011: Op18 = 1; // Func 000011 SRA #18 R type   or it can be    Opcode 000011 JAL #2 J type
 6'b001001: Op19 = 1; // Opcode 001001 ADDiu #2 I type 
 6'b001110: Op20 = 1; // Opcode 001110 XORi #4 I type
 6'b001101: Op21 = 1; // Opcode 001101 ORi #5 I type 
 6'b000101: Op22 = 1; // Opcode 000101 BNE #7 I type
 6'b100110: Op23 = 1; // Opcode 000110 BLEZ #8 I type 
 6'b000111: Op24 = 1; // Opcode 000111 BGTZ #9 I type
 6'b000001: Op25 = 1; // Opcode 000001 BGEZ #10 I type 
 6'b101011: Op26 = 1; // Opcode 101011 SW #12 I type
 6'b101000: Op27 = 1; // Opcode 101000 SB #14 I type 
 6'b001010: Op28 = 1; // Opcode 001010 SLTi #15 I type
 6'b001111: Op29 = 1; // Opcode 001111 Lui #16 I type 
 //6'b??????: Op30 = 1; No need
 //6'b??????: Op31 = 1; No need 
 //6'b??????: Op32 = 1; No need
 default: begin 
 Op1 = 0;
 Op2 = 0;
 Op3 = 0;
 Op4 = 0;
 Op5 = 0;
 Op6 = 0;
 Op7 = 0;
 Op8 = 0;
 Op9 = 0;
 Op10 = 0;
 Op11 = 0;
 Op12 = 0;
 Op13 = 0;
 Op14 = 0;
 Op15 = 0;
 Op16 = 0;
 Op17 = 0;
 Op18 = 0;
 Op19 = 0;
 Op20 = 0;
 Op21 = 0;
 Op22 = 0;
 Op23 = 0;
 Op24 = 0;
 Op25 = 0;
 Op26 = 0;
 Op27 = 0;
 Op28 = 0;
 Op29 = 0;
 Op30 = 0;
 Op31 = 0;
 Op32 = 0; 
  end 
  endcase 
 end 
end
endmodule
