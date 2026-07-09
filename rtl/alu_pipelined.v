module alu_pipelined #(
    parameter DATA_WIDTH = 32
)(
    input  wire                  clk,
    input  wire                  rst,
    input  wire [DATA_WIDTH-1:0] a,
    input  wire [DATA_WIDTH-1:0] b,
    input  wire [2:0]            opcode,
    output reg  [DATA_WIDTH-1:0] result
);

    // -------- STAGE 1 REGISTERS --------
    reg [DATA_WIDTH-1:0] a_r, b_r;
    reg [2:0] opcode_r;

    // -------- STAGE 2 REGISTER --------
    reg [DATA_WIDTH-1:0] alu_out;

    always @(posedge clk) begin
        if (rst) begin
            a_r      <= 0;
            b_r      <= 0;
            opcode_r <= 0;
            alu_out  <= 0;
            result   <= 0;
        end else begin
            // Stage 1
            a_r      <= a;
            b_r      <= b;
            opcode_r <= opcode;

            // Stage 2
            case (opcode_r)
                3'b000: alu_out <= a_r + b_r;
                3'b001: alu_out <= a_r - b_r;
                3'b010: alu_out <= a_r & b_r;
                3'b011: alu_out <= a_r | b_r;
                3'b100: alu_out <= a_r ^ b_r;
                default: alu_out <= 0;
            endcase

            // Stage 3
            result <= alu_out;
        end
    end

endmodule
