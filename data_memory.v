module data_memory (
    input wire clk, we, re,
    input wire [31:0] addr, wd,
    output wire [31:0] rd
);
    reg [31:0] memory [0:255];

    always @(posedge clk) begin
        if (we) memory[addr >> 2] <= wd;
    end

    assign rd = re ? memory[addr >> 2] : 32'b0;
endmodule
