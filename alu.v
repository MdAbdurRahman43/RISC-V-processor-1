module alu (
    input wire [31:0] a, b,
    input wire [3:0] alu_ctrl,
    output wire [31:0] result
);
    assign result = (alu_ctrl == 4'b0000) ? (a + b) :
                    (alu_ctrl == 4'b0001) ? (a - b) :
                    (alu_ctrl == 4'b0010) ? (a & b) :
                    (alu_ctrl == 4'b0011) ? (a | b) :
                    32'b0;
endmodule
