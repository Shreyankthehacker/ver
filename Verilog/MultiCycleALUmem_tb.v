`timescale 1ns / 1ps

module MultiCycleALU_tb;
    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg [1:0] A;
    reg [1:0] B;
    reg [2:0] Op;
    reg [3:0] Address;

    // Outputs
    wire [2:0] Y;
    wire [2:0] MemOut;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    MultiCycleALU uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .A(A),
        .B(B),
        .Op(Op),
        .Address(Address),
        .Y(Y),
        .MemOut(MemOut),
        .done(done)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // Clock period of 10ns

    initial begin
        $dumpfile("MultiCycleALUmem.vcd");
        $dumpvars(0,MultiCycleALUmem_tb.v);
        // Initialize inputs
        reset = 1;
        start = 0;
        A = 0;
        B = 0;
        Op = 0;
        Address = 0;

        // Reset the ALU
        #10 reset = 0;

        // Test case 1: Addition (A + B)
        A = 2'b01; B = 2'b10; Op = 3'b000; start = 1; #10;
        start = 0; wait(done); #10;

        // Test case 2: Memory Write
        A = 2'b11; Address = 4'b0010; Op = 3'b110; start = 1; #10;
        start = 0; wait(done); #10;

        // Test case 3: Memory Read
        Address = 4'b0010; Op = 3'b100; start = 1; #10;
        start = 0; wait(done); #10;

        // Test case 4: Subtraction (A - B)
        A = 2'b11; B = 2'b01; Op = 3'b001; start = 1; #10;
        start = 0; wait(done); #10;

        $stop;
    end
endmodule
