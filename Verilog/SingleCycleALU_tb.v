`timescale 1ns / 1ps

module SingleCycleALU_tb;
    // Inputs
    reg [1:0] A;
    reg [1:0] B;
    reg [2:0] Op;
    reg [3:0] Address;
    reg [2:0] MemOp;
    reg clk;

    // Outputs
    wire [2:0] Y;
    wire [2:0] MemOut;

    // Instantiate the Unit Under Test (UUT)
    SingleCycleALU uut (
        .A(A),
        .B(B),
        .Op(Op),
        .Address(Address),
        .MemOp(MemOp),
        .clk(clk),
        .Y(Y),
        .MemOut(MemOut)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // Clock period of 10ns

    initial begin
        $dumpfile("SingleCycleALU.vcd");
        $dumpvars(0,SingleCycleALU_tb);
        // Initialize inputs
        A = 0; B = 0; Op = 0; Address = 0; MemOp = 0;

        // Test 1: Addition (A + B)
        A = 2'b01; B = 2'b10; Op = 3'b000; MemOp = 3'b000; #10;

        // Test 2: Store result in memory
        Address = 4'b0001; MemOp = 3'b001; #10;

        // Test 3: Load result from memory
        MemOp = 3'b010; #10;

        // Test 4: Subtraction (A - B)
        A = 2'b10; B = 2'b01; Op = 3'b001; MemOp = 3'b000; #10;

        // Test 5: Store result in a different address
        Address = 4'b0010; MemOp = 3'b001; #10;

        // Test 6: Load result from the second address
        Address = 4'b0010; MemOp = 3'b010; #10;

        $stop;
    end
endmodule
