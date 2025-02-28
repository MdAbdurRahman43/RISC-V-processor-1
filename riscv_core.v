module riscv_core (
    input wire clk,
    input wire rst,
    output wire [31:0] pc,
    output wire [31:0] instruction
);
    // Internal Wires
    wire [31:0] pc_next, pc_current;
    wire [31:0] rd1, rd2, imm;
    wire [31:0] alu_result, mem_data;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode, funct7;
    wire [2:0] funct3;
    wire [3:0] alu_ctrl;
    wire reg_write, alu_src, mem_write, mem_read;

    // PC Register
    reg [31:0] pc_reg;
    always @(posedge clk or posedge rst) begin
        if (rst) pc_reg <= 0;
        else pc_reg <= pc_next;
    end
    assign pc = pc_reg;

    // Instruction Memory
    instruction_memory imem (.addr(pc), .data(instruction));

    // Decode Unit
    decode_unit decode (.instruction(instruction), .rs1(rs1), .rs2(rs2), .rd(rd), .opcode(opcode), .funct3(funct3), .funct7(funct7), .imm(imm));

    // Register File
    register_file regfile (.clk(clk), .rst(rst), .we(reg_write), .rs1(rs1), .rs2(rs2), .rd(rd), .wd(alu_result), .rd1(rd1), .rd2(rd2));

    // Control Unit
    control_unit control (.opcode(opcode), .reg_write(reg_write), .alu_src(alu_src), .mem_write(mem_write), .mem_read(mem_read));

    // ALU
    alu alu_unit (.a(rd1), .b(alu_src ? imm : rd2), .alu_ctrl(alu_ctrl), .result(alu_result));

    // Data Memory
    data_memory dmem (.addr(alu_result), .wd(rd2), .we(mem_write), .re(mem_read), .clk(clk), .rd(mem_data));

    // Next PC Logic (Simple Sequential)
    assign pc_next = pc + 4;
endmodule
