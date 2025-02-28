module control_unit (
    input wire [6:0] opcode,
    output wire reg_write, alu_src, mem_write, mem_read
);
    assign reg_write = (opcode == 7'b0110011) || (opcode == 7'b0010011);  // R-type and I-type
    assign alu_src = (opcode == 7'b0010011);  // Immediate operations
    assign mem_write = (opcode == 7'b0100011);  // Store
    assign mem_read = (opcode == 7'b0000011);  // Load
endmodule
