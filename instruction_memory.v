module instruction_memory (
    input wire [31:0] addr,
    output wire [31:0] data
);
    reg [31:0] memory [0:255];  // 256 x 32-bit memory

    initial begin
        $readmemh("instructions.mem", memory);  
        $display("Instruction Memory Loaded:");
        $display("0: %h", memory[0]);
        $display("1: %h", memory[1]);
        $display("2: %h", memory[2]);
        $display("3: %h", memory[3]);
        $display("4: %h", memory[4]);// Load Instructions from File
    end

    assign data = memory[addr >> 2];  // Fetch instruction
endmodule
