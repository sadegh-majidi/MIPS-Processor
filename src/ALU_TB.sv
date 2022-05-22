module ALU_TB();
wire signed[31:0] Output;
reg signed[31:0] NewOutput;
reg signed[31:0] A, B, C;
reg ADD, SUB, ADDu, SUBu, MUL, DIV, AND, OR, NOR, XOR, SRL, SLL, SRA, SLA, ALU_Enable;
ALU alu(Output, A, B, C, ADD, SUB, ADDu, SUBu, MUL, DIV, AND, OR, XOR, NOR, SRL, SLL, SRA, SLA, ALU_Enable);
initial begin
ADD = 0;
SUB = 0; 
ADDu = 0; 
SUBu = 0; 
MUL = 0;
DIV = 0; 
AND = 0; 
OR = 0; 
NOR = 0;
XOR = 0; 
SRL = 0; 
SLL = 0;
SRA = 0; 
SLA = 0;
ALU_Enable = 1;
A = 32'b11111111111111111111111111111101;//{29'b1, 3'b101}; // -3 signed , unsigned very big 2 ^ 32 - 3
B = 32'b00000000000000000000000000000101;//{29'b0, 3'b101}; // 5
C = 32'b0;
ADD = 1;
#5;
$display(Output); // 2
#5;
ADD = 0;
ADDu = 1;
#5;
$display(Output); // big number 2^32 + 2 = 2
#5;
ADDu = 0;
OR = 1;
#5;
$display(Output); // -3 
#5;
OR = 0;
XOR = 1;
#5;
$display(Output); // -8
#5;
XOR = 0;
NOR = 1;
#5;
$display(Output); // 2
#5;
NOR = 0;
AND = 1;
#5;
$display(Output); // 5
#5;
AND = 0;
SRL = 1;
C = 32'b00000000000000000000000000000001;//{31'b0, 1'b1}; // C = 1
B = 32'b11111111111111111111111111111101;//{29'b1, 3'b101}; // B = -3
#5;
$display(Output); // 0111...1110 = 2,147,483,646
#5;
SRL = 0;
SRA = 1;
#5;
$display(Output); // -2
#5;
SRA = 0;
SLA = 1;
C = 32'b1;
#5;
$display(Output); // -6
#5;
SLA = 0;
SLL = 1;
#5;
$display(Output); // -6
#5;
SLL = 0;
MUL = 1;
A = 32'b11111111111111111111111111111000;// -8
B = 32'b00000000000000000000000000000100;// 4
#5;
$display(Output); // -32 = -8 * 4
#5;
MUL = 0;
DIV = 1;
#5;
$display(Output); // -2 = -8 / 4
#5;
A = 32'b00000000000000000000000000001000;// 8
#5;
$display(Output); // 2 = 8 / 4
#5;
DIV = 0;
MUL = 1;
A = 32'b11111111111111111111111111111000; // -8
B = 32'b11111111111111111111111111111110; // -2
#5;
$display(Output); // 16 = 8 * 2
#5;
$stop;
end
endmodule
