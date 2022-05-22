module alu(
    input signed [31:0] A,
    input signed [31:0] B,
    // input [31:0] A_unsigned,
    // input [31:0] B_unsigned,
    input [5:0] aluctl,
    output reg [31:0] C,
    // output bcond
    );


    
    always @(*) begin
        case (aluctl)
            0: begin
                 C = A + B;
                 ready = 1;
            end


            // 0:  C = A ^ B;
            // 1:  C = A_unsigned << B_unsigned;
            // 2:  C = A << B;
            // 3:  C = A_unsigned >> B_unsigned;
            // 4:  C = A - B;
            // 5:  C = A >> B;
            // 6:  C = 
            // 7:  C = ? : 
            // 8:  C = A_unsigned - B_unsigned;;
            // 9:  C = A | B;
            // 10: C = A ~| B;
            // 11: C = A_unsigned + B_unsigned;
            // 12: C = A * B;
            // 13: C = A / B;
            // 14: C = A & B;
            // 15: C = A + B;
            // 16: C = C;
            // 17: C = A >> B;
            default: C = 16'bz;
        endcase
    end
     
endmodule
