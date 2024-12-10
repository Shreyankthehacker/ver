module ALU_2bit (
    input [1:0] A,      // 2-bit input A
    input [1:0] B,      // 2-bit input B
    input [1:0] Op,     // 2-bit operation selector
    output reg [2:0] Y  // 3-bit output to accommodate overflow
);
    always @(*) begin
        case (Op)
            2'b00: Y = A + B;         // Addition
            2'b01: Y = A - B;         // Subtraction
            2'b10: Y = A & B;         // Bitwise AND
            2'b11: Y = A | B;         // Bitwise OR
            default: Y = 3'b000;      // Default case
        endcase
    end
endmodule
