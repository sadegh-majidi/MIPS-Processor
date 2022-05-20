module control_unit(
        input  wire	[5:0]	opcode
);
    	always @(*) begin
            case (opcode)
            // R format
                6'b100110: begin
                    // rd ← rs ^ rt
                end
                6'b000000: begin
                    // rd ← rt << Sh.AMOUNT
                end
                6'b000100: begin
                    // rd ← rs << rt
                end
                6'b000010: begin
                    // rd ← rt >> Sh.AMOUNT
                end
                6'b100010: begin
                    // rd ← rs – rt
                end
                6'b000110: begin
                    // rd ← rt >> rs
                end
                6'b101010: begin
                    // rd ←rs<rt signed comparison
                end
                6'b001100: begin
                    // Finish cpu opration
                end
                6'b100011: begin
                    // rd ← rt - rs
                end
                6'b100101: begin
                    // rd ← rs| rt
                end
                6'b100111: begin
                    // rd ← rs ~| rt
                end
                6'b100001: begin
                    // rd ← rs + rt
                end
                6'b011000: begin
                    // rd ← rs * rt
                end
                6'b011010: begin
                    // rd ← rs / rt
                end
                6'b100100: begin
                    // rd ← rs & rt
                end
                6'b100000: begin
                    // rd ← rs + rt
                end
                6'b001000: begin
                    // PC ← rs
                end
                6'b000011: begin
                    // rd ← rt >> Sh.AMOUNT
                end

            // I format

                6'b001000: begin
                    // rt ← rs + SIGN EXTEND (Imm) ADDi
                end
                6'b001001: begin
                    // rt ← rs + SIGN EXTEND (Imm) ADDiu(unsigned)
                end
                6'b001100: begin
                    // rt ←rs & SIGN EXTEND (Imm) ANDi
                end
                6'b001110: begin
                    // rt ← rs ~ SIGN EXTEND (Imm)
                end
                6'b001110: begin
                    // rt ← rs | SIGN EXTEND (Imm)
                end
                6'b000100: begin
                    // rs == rt: PC ← PC + SIGN EXTEND(Imm | “00”)
                end
                6'b000101: begin
                    // rs!= rt: PC ← PC + SIGN EXTEND (Imm | “00”)
                end
                6'b000110: begin
                    // rs <= 0: PC ← PC + SIGN EXTEND (Imm | “00”)
                end
                6'b000111: begin
                    // es > 0: PC ← PC + SIGN EXTEND (Imm | “00”)
                end
                6'b000001: begin
                    // rs >= 0: PC ← PC + SIGN EXTEND (Imm | “00”)
                end
                6'b100011: begin
                    // rt ← MEM [$rs+ SIGN EXTEND (Imm)]
                end
                6'b101011: begin
                    // MEM [$rs+ SIGN EXTEND (Imm)] ← rt
                end
                6'b100000: begin
                    // rt[7:0] ← MEM [$rs+ SIGN EXTEND (Imm)]
                end
                6'b101000: begin
                    // MEM [$rs+ SIGN EXTEND (Imm)] ← rt [7:0]
                end
                6'b001010: begin
                    // Set to 1 if Less, rs< SIGN EXTEND (Imm) , rt=1
                end
                6'b001111: begin
                    // The immediate value is shifted left 16 bits and store in register. The lower 16 bits are zeroes
                    // rt← {SIGN EXTEND (Imm),0*16}
                end

            // J format

                6'b000010: begin
                    // PC←{( PC), address,00}
                end
                6'b000011: begin
                    // R[31] ← PC then go to procedure address
                    // PC←{( PC), address,00}
                end
            endcase
	end
endmodule