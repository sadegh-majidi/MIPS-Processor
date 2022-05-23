
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
    input   [31:0] inst;
    input   [7:0]  mem_data_out[0:3];
    input          clk;
    input          rst_b;

    output reg [31:0] inst_addr;
    output  [31:0] mem_addr;
    output  [7:0]  mem_data_in[0:3];
    output         mem_write_en;
    output reg     halted;

	wire [5:0]  opcode;
    wire [5:0]  func;
	wire [4:0]  rs_num;
	wire [4:0]  rt_num;
	wire [4:0]  rd_num;
    wire [4:0]  sh_amount;
    wire [15:0] imm;
    wire [31:0] pc_branch;

	assign opcode       = inst[31:26];
	assign func         = inst[5:0];
	assign rs_num       = inst[25:21];
	assign rt_num       = inst[20:16];
	assign rd_num       = inst[15:11];
    assign sh_amount    = inst[10:6];
    assign imm          = inst[15:0];
    assign pc_branch = 32'b0;


    always @(posedge clk) begin
        if(!rst_b) begin
           inst_addr <= 32'b0;  
        end
        else begin
            if(pc_branch != 32'b0) begin
                inst_addr <= inst_addr + pc_branch;
            end
            else begin 
                  inst_addr <= inst_addr + 32'd4;
            end
           
        end
        $display("time mips T=%00t", $realtime);
        $display("inst=%b opcode=%b func=%b pc=%b",inst , opcode, func, inst_addr);
    end

    control_unit control_unit_ (
        .clk(clk),
        .rst_b(rst_b),
        .opcode(opcode),
        .func(func),
        .rs_num(rs_num),
        .rt_num(rt_num),
        .rd_num(rd_num),
        .sh_amount(sh_amount),
        .imm(imm),
        .pc_branch(pc_branch),
        .halted_signal(halted)
    );
endmodule
