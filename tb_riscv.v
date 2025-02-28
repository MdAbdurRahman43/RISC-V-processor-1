module tb_riscv;
    reg clk, rst;
    wire [31:0] pc, instruction;
    wire [31:0] alu_result, rd1, rd2;
    wire reg_write, alu_src, mem_write, mem_read;

    // Instantiate Core
    riscv_core uut (
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .instruction(instruction)
    );

    // Internal Signal Assignments
    assign alu_result = uut.alu_unit.result;  // ALU output
    assign rd1 = uut.regfile.rd1;             // Register file read data 1
    assign rd2 = uut.regfile.rd2;             // Register file read data 2
    assign reg_write = uut.control.reg_write; // Register write enable
    assign alu_src = uut.control.alu_src;     // ALU source select
    assign mem_write = uut.control.mem_write; // Memory write enable
    assign mem_read = uut.control.mem_read;   // Memory read enable

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock period = 10ns
    end

    // Reset and Test
    initial begin
        rst = 1;
        #10 rst = 0;
    end

    // Monitor Signals
    initial begin
        $monitor("Time=%0t | PC=%h | Inst=%h | ALU_out=%h | RegWrite=%b | ALU_src=%b | MemWrite=%b | MemRead=%b | rd1=%h | rd2=%h", 
                 $time, pc, instruction, alu_result, reg_write, alu_src, mem_write, mem_read, rd1, rd2);
    end

    // Stop Simulation When Out of Instructions
    always @(posedge clk) begin
        if (pc >= 16) begin  // Stop when PC exceeds last instruction address (0x10)
            $display("Execution complete. Stopping simulation.");
            $finish;
        end
    end
endmodule
