module alu_pipelined_deep #(
    parameter DATA_WIDTH = 32
)(
    input  wire                  clk,
    input  wire                  rst,
    input  wire [DATA_WIDTH-1:0] a,
    input  wire [DATA_WIDTH-1:0] b,
    input  wire [2:0]            opcode,
    output reg  [DATA_WIDTH-1:0] result
);

    // ================================
    // Stage 1: Input Registers
    // ================================
    reg [DATA_WIDTH-1:0] a_r, b_r;
    reg [2:0] opcode_r;

    // ================================
    // Stage 2: Pre-compute Operations
    // ================================
    reg [DATA_WIDTH-1:0] add_res;
    reg [DATA_WIDTH-1:0] sub_res;
    reg [DATA_WIDTH-1:0] and_res;
    reg [DATA_WIDTH-1:0] or_res;
    reg [DATA_WIDTH-1:0] xor_res;

    // ================================
    // Stage 3: Result Selection
    // ================================
    reg [DATA_WIDTH-1:0] sel_res;
    reg [2:0] opcode_rr;

    // ================================
    // Stage 4: Output Register
    // ================================
    reg [DATA_WIDTH-1:0] result_r;

    // ================================
    // Sequential Logic
    // ================================
    always @(posedge clk) begin
        if (rst) begin
            // Stage 1
            a_r <= 0;
            b_r <= 0;
            opcode_r <= 0;

            // Stage 2
            add_res <= 0;
            sub_res <= 0;
            and_res <= 0;
            or_res  <= 0;
            xor_res <= 0;

            // Stage 3
            sel_res <= 0;
            opcode_rr <= 0;

            // Stage 4
            result_r <= 0;
            result <= 0;
        end else begin
            // -----------------------------
            // Stage 1: Register inputs
            // -----------------------------
            a_r <= a;
            b_r <= b;
            opcode_r <= opcode;

            // -----------------------------
            // Stage 2: Pre-compute ALU ops
            // -----------------------------
            add_res <= a_r + b_r;
            sub_res <= a_r - b_r;
            and_res <= a_r & b_r;
            or_res  <= a_r | b_r;
            xor_res <= a_r ^ b_r;

            // -----------------------------
            // Stage 3: Select result
            // -----------------------------
            opcode_rr <= opcode_r;
            case (opcode_r)
                3'b000: sel_res <= add_res;
                3'b001: sel_res <= sub_res;
                3'b010: sel_res <= and_res;
                3'b011: sel_res <= or_res;
                3'b100: sel_res <= xor_res;
                default: sel_res <= 0;
            endcase

            // -----------------------------
            // Stage 4: Output register
            // -----------------------------
            result_r <= sel_res;
            result   <= result_r;
        end
    end

endmodule
