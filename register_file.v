module register_file (
    input wire clk, rst, we,
    input wire [4:0] rs1, rs2, rd,
    input wire [31:0] wd,
    output wire [31:0] rd1, rd2
);
    reg [31:0] registers [0:31];

    // Register Initialization
    integer i;
    always @(posedge rst) begin
        for (i = 0; i < 32; i = i + 1) registers[i] <= 0;
    end

    always @(posedge clk) begin
        if (we && rd != 0) registers[rd] <= wd;  // Write back to register
    end

    assign rd1 = registers[rs1];
    assign rd2 = registers[rs2];
endmodule
