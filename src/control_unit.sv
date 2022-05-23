module control_unit(
        // inst 
        input clk, rst_b,
        input[5:0] opcode,func,
        // data
        input[4:0] rs_num, rt_num, rd_num,
        input[4:0]  sh_amount,
        input[15:0] imm,
        output reg halted_signal
        output reg [15:0] pc_branch
);

    wire [15:0] tmp_pc_branch;
    wire [31:0] rs_data, rt_data;
    reg tmp_halted_signal;
    /* verilator lint_off UNOPTFLAT */
    reg [4:0] reg_rs_num, reg_rt_num, reg_rd_num;
    reg [31:0] rd_data_output;
    reg rd_we;
    regfile regfile_1 (
            .rs_data(rs_data),
            .rt_data(rt_data),
            .rs_num(reg_rs_num),
            .rt_num(reg_rt_num),
            .rd_num(reg_rd_num),
            .rd_data(rd_data_output),
            .rd_we(rd_we),
            .clk(clk),
            .rst_b(rst_b),
            .halted(tmp_halted_signal)
        );

    assign tmp_pc_branch = 16'b0;

    always @(posedge clk) begin
       if(!rst_b) begin
           halted_signal <= 1'b0;
       end
       else begin
           pc_branch <= tmp_pc_branch
           halted_signal <= tmp_halted_signal;
       end
    end

    always @(*) begin
        // R type
        if (opcode == 6'b0) begin
            case(func) 
                // add hamchin chizi
                6'b100110: begin //xor
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data ^ rt_data;
                    rd_we = 1'b1;
                end
                6'b000000: begin //sll
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data << sh_amount;
                    rd_we = 1'b1;
                end
                6'b000100: begin //sllv
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data << rs_data;
                    rd_we = 1'b1;
                end
                 6'b100010: begin //sub
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data - rt_data;
                    rd_we = 1'b1;
                end
                6'b000010: begin //srl
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data >> rt_data;
                    rd_we = 1'b1;
                end
                6'b000110: begin //srlv
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data >> sh_amount;
                    rd_we = 1'b1;
                end
                6'b101010: begin //slt
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data <<< rt_data[4:0];
                    rd_we = 1'b1;
                end
                6'b001100: begin //syscall
                    tmp_halted_signal = 1'b1;
                end
                6'b100011: begin //subu
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data - rt_data;
                    rd_we = 1'b1;
                end
                6'b100101: begin //or
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data | rt_data;
                    rd_we = 1'b1;
                end
                6'b100111: begin //nor
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = ~(rs_data | rt_data);
                    rd_we = 1'b1;
                end
                6'b100001: begin //addu
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data + rt_data;
                    rd_we = 1'b1;
                end
                6'b011000: begin //mult
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data * rt_data;
                    rd_we = 1'b1;
                end
                6'b011010: begin //div
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data / rt_data;
                    rd_we = 1'b1;
                end
                6'b100100: begin //and
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data & rt_data;
                    rd_we = 1'b1;
                end
                6'b100000: begin //add
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data + rt_data;
                    rd_we = 1'b1;
                end
                6'b000011: begin //sra
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rd_num;
                    rd_data_output = rs_data >> sh_amount[4:0];
                    rd_we = 1'b1;
                end
                default: begin  
                    tmp_halted_signal = 1'b1;
                    rd_we = 1'b0;
                end  
            endcase
        end
        else begin
            case (opcode)
            // I format
                6'b001000: begin //addi
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rt_num;
                    /* verilator lint_off WIDTH */
                    rd_data_output = rs_data + imm;
                    rd_we = 1'b1;
                end
                6'b001001: begin //addiu
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rt_num;
                    /* verilator lint_off WIDTH */
                    rd_data_output = rs_data + imm;
                    rd_we = 1'b1;
                end
                6'b001100: begin //andi
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rt_num;
                    /* verilator lint_off WIDTH */
                    rd_data_output = rs_data * imm;
                    rd_we = 1'b1;
                end
                6'b001110: begin //xori
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rt_num;
                    /* verilator lint_off WIDTH */
                    rd_data_output = rs_data ^ imm;
                    rd_we = 1'b1;
                end
                6'b001110: begin //ori
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rt_num;
                    /* verilator lint_off WIDTH */
                    rd_data_output = rs_data | imm;
                    rd_we = 1'b1;
                end
                6'b000100: begin //beq TODO
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    tmp_pc_branch = (rs_data == rt_data)?  imm|2'b0 : 0;
                    
                end
                6'b000101: begin //bne //TODO
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    tmp_pc_branch = (rs_data != rt_data)?  imm|2'b0 : 0;
                end
                6'b000110: begin //blez //TODO
                    // rs <= 0: PC ← PC + SIGN EXTEND (Imm | “00”)
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    tmp_pc_branch = (rs_data <= 0)?  imm|2'b0 : 0;
                end
                6'b000111: begin //bgtz //TODO
                    // es > 0: PC ← PC + SIGN EXTEND (Imm | “00”)
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    tmp_pc_branch = (rs_data > 0)?  imm|2'b0 : 0;
                end
                6'b000001: begin //bgez //TODO
                    // rs >= 0: PC ← PC + SIGN EXTEND (Imm | “00”)
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    tmp_pc_branch = (rs_data >= 0)?  imm|2'b0 : 0;
                end
                6'b100011: begin //lw //TODO
                    // rt ← MEM [$rs + SIGN EXTEND (Imm)]
                    // new instruction
                    aluctl[5:1] = 5'd23;
                end
                6'b101011: begin //sw //TODO
                    // MEM [$rs+ SIGN EXTEND (Imm)] ← rt
                    // new instruction
                    aluctl[5:1] = 5'd24;
                end
                6'b100000: begin //lb //TODO
                    // rt[7:0] ← MEM [$rs+ SIGN EXTEND (Imm)]
                    // new instruction
                    aluctl[5:1] = 5'd25;
                end
                6'b101000: begin //sb //TODO
                    // MEM [$rs+ SIGN EXTEND (Imm)] ← rt [7:0]
                    // new instruction
                    aluctl[5:1] = 5'd26;
                end
                6'b001010: begin //slti //TODO
                    // Set to 1 if Less, rs< SIGN EXTEND (Imm) , rt=1
                    // new instruction
                    aluctl[5:1] = 5'd27;
                end
                6'b001111: begin //lui
                    reg_rs_num = rs_num;
                    reg_rt_num = rt_num;
                    reg_rd_num = rt_num;
                    /* verilator lint_off WIDTH */
                    rd_data_output = {imm, 16'b0};
                    rd_we = 1'b1;
                end
            // J format
            // todo: J
                6'b000010: begin
                    // PC←{( PC), address,00}
                end
                6'b000011: begin
                    // R[31] ← PC then go to procedure address
                    // PC←{( PC), address,00}
                end
                default: begin  
                    tmp_halted_signal = 1'b1;
                    rd_we = 1'b0;
                end
            endcase
            end
        $display("time CU T=%00t", $realtime);
        $display("CU im opcode=%b func=%b", opcode, func);
    end

    
endmodule
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