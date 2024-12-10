module SingleCycleALU (
    input [1:0] A,          // 2-bit input A
    input [1:0] B,          // 2-bit input B
    input [2:0] Op,         // 3-bit operation selector
    input [3:0] Address,    // 4-bit memory address
    input [2:0] MemOp,      // Memory operation (load/store control)
    input clk,              // Clock signal
    output reg [2:0] Y,     // 3-bit ALU output
    output reg [2:0] MemOut // Memory output (for load operations)
);
    reg [2:0] Memory [0:15]; // Simple memory array with 16 locations (3 bits each)

    always @(posedge clk) begin
        // Perform ALU operation based on Op
        case (Op)
            3'b000: Y = A + B;        // Addition
            3'b001: Y = A - B;        // Subtraction
            3'b010: Y = A & B;        // Bitwise AND
            3'b011: Y = A | B;        // Bitwise OR
            3'b100: Y = ~A;           // Bitwise NOT
            default: Y = 3'b000;      // Default case
        endcase

        // Perform memory operation based on MemOp
        case (MemOp)
            3'b000: ;                 // No memory operation
            3'b001: Memory[Address] = Y; // Store ALU result to memory
            3'b010: MemOut = Memory[Address]; // Load memory to output
            default: MemOut = 3'b000; // Default case
        endcase
    end
endmodule
