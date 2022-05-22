module control_unit(
        // inst 
        input  wire	[5:0]	opcode,
        input  wire	[5:0]	func,
        input  wire	[15:0]  imm,
        input  wire	[4:0]   sh_amount,
        input  wire	[31:0]  jaddr,
        input  wire	[31:0]  seimm,



        // data
        input  wire	[31:0]	rs_data,
        input  wire	[31:0]	rt_data,
        input  wire	[31:0]	alu_out_data, // convert to rd_data_output
        input  wire alu_ready,

        output  wire halted_signal,
        output wire	rd_we,
        output wire	[31:0]	A,
        output wire	[31:0]	B,
        output wire	[5:0]   aluctl,
        output wire	[31:0]	rd_data_output,
);
/*
    	always @(*) begin
            if (opcode == 6'b0) begin
                aluctl[0] <= 0;
                case (func)
                // R format
                6'b100110: begin
                    // rd ← rs ^ rt
                    aluctl[5:1] = 5'd0;
                end
                6'b000000: begin
                    // rd ← rt << Sh.AMOUNT
                    aluctl[5:1] = 5'd1;
                end
                6'b000100: begin
                    // rd ← rs << rt
                    aluctl[5:1] = 5'd2;
                end
                6'b000010: begin
                    // rd ← rt >> Sh.AMOUNT (Shift right logical)Unsigned right shift
                    aluctl[5:1] = 5'd3;
                end
                6'b100010: begin
                    // rd ← rs – rt
                    aluctl[5:1] = 5'd4;
                end
                6'b000110: begin
                    // rd ← rt >> rs
                    aluctl[5:1] = 5'd5;
                end
                6'b101010: begin
                    // rd ←rs<rt signed comparison
                    aluctl[5:1] = 5'd6;
                end
                6'b001100: begin
                    // Finish cpu opration
                    aluctl[5:1] = 5'd7;
                end
                6'b100011: begin
                    // rd ← rt - rs unsigned
                    aluctl[5:1] = 5'd8;
                end
                6'b100101: begin
                    // rd ← rs| rt
                    aluctl[5:1] = 5'd9;
                end
                6'b100111: begin
                    // rd ← rs ~| rt
                    aluctl[5:1] = 5'd10;
                end
                6'b100001: begin
                    // rd ← rt + rs unsigned
                    aluctl[5:1] = 5'd11;
                end
                6'b011000: begin
                    // rd ← rs * rt
                    aluctl[5:1] = 5'd12;
                end
                6'b011010: begin
                    // rd ← rs / rt
                    aluctl[5:1] = 5'd13;
                end
                6'b100100: begin
                    // rd ← rs & rt
                    aluctl[5:1] = 5'd14;
                end
                6'b100000: begin
                    // rd ← rs + rt
                    aluctl[5:1] = 5'd15;
                end
                6'b001000: begin
                    // PC ← rs
                    aluctl[5:1] = 5'd16;
                end
                6'b000011: begin
                    // rd ← rt >> Sh.AMOUNT signed right shift
                    aluctl[5:1] = 5'd17;
                end
            endcase
            end
            else begin
                aluctl[0] <= 1;
                case (opcode)
                // I format
                    6'b001000: begin
                        // rt ← rs + SIGN EXTEND (Imm) ADDi
                        aluctl[5:1] = 5'd15;
                    end
                    6'b001001: begin
                        // rt ← rs + SIGN EXTEND (Imm) ADDiu(unsigned)
                        aluctl[5:1] = 5'd11;
                    end
                    6'b001100: begin
                        // rt ←rs & SIGN EXTEND (Imm) ANDi
                        aluctl[5:1] = 5'd14;
                    end
                    6'b001110: begin
                        // rt ← rs ^ SIGN EXTEND (Imm)
                        aluctl[5:1] = 5'd0;
                    end
                    6'b001110: begin
                        // rt ← rs | SIGN EXTEND (Imm)
                        aluctl[5:1] = 5'd9;
                    end
                    6'b000100: begin
                        // rs == rt: PC ← PC + SIGN EXTEND(Imm | “00”)
                        // new instruction
                        aluctl[5:1] = 5'd18;
                    end
                    6'b000101: begin
                        // rs != rt: PC ← PC + SIGN EXTEND (Imm | “00”)
                        // new instruction
                        aluctl[5:1] = 5'd19;
                    end
                    6'b000110: begin
                        // rs <= 0: PC ← PC + SIGN EXTEND (Imm | “00”)
                        // new instruction
                        aluctl[5:1] = 5'd20;
                    end
                    6'b000111: begin
                        // es > 0: PC ← PC + SIGN EXTEND (Imm | “00”)
                        // new instruction
                        aluctl[5:1] = 5'd21;
                    end
                    6'b000001: begin
                        // rs >= 0: PC ← PC + SIGN EXTEND (Imm | “00”)
                        // new instruction
                        aluctl[5:1] = 5'd22;
                    end
                    6'b100011: begin
                        // rt ← MEM [$rs + SIGN EXTEND (Imm)]
                        // new instruction
                        aluctl[5:1] = 5'd23;
                    end
                    6'b101011: begin
                        // MEM [$rs+ SIGN EXTEND (Imm)] ← rt
                        // new instruction
                        aluctl[5:1] = 5'd24;
                    end
                    6'b100000: begin
                        // rt[7:0] ← MEM [$rs+ SIGN EXTEND (Imm)]
                        // new instruction
                        aluctl[5:1] = 5'd25;
                    end
                    6'b101000: begin
                        // MEM [$rs+ SIGN EXTEND (Imm)] ← rt [7:0]
                        // new instruction
                        aluctl[5:1] = 5'd26;
                    end
                    6'b001010: begin
                        // Set to 1 if Less, rs< SIGN EXTEND (Imm) , rt=1
                        // new instruction
                        aluctl[5:1] = 5'd27;
                    end
                    6'b001111: begin
                        // The immediate value is shifted left 16 bits and store in register. The lower 16 bits are zeroes
                        // rt← {SIGN EXTEND (Imm),0*16}
                        // new instruction
                        aluctl[5:1] = 5'd28;
                    end

                // J format
                // todo: J
                    // 6'b000010: begin
                    //     // PC←{( PC), address,00}
                    // end
                    // 6'b000011: begin
                    //     // R[31] ← PC then go to procedure address
                    //     // PC←{( PC), address,00}
                    // end
                endcase
            end
	end
    */


reg  [31:0] pc;
initial begin
    pc <= 32'd0;
end


assign rd_data_output = alu_ready ? rd_data_output : 32'bx
assign rd_we = alu_ready ? 1 : 0

always @(*) begin
    // R type
    if (opcode == 6'b0) begin
        case (func) 
            6'b100000: begin
                aluctl <= 6'd0;
                A <= rs_data;
                B <= rt_data;
            end

            6'b001100: begin
                halted_signal <= 1;
            end
        endcase
    end
end

endmodule