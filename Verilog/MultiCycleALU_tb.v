`timescale 1ns / 1ps

module MultiCycleALU_tb;
    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg [1:0] A;
    reg [1:0] B;
    reg [1:0] Op;

    // Outputs
    wire [2:0] Y;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    MultiCycleALU uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .A(A),
        .B(B),
        .Op(Op),
        .Y(Y),
        .done(done)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        $dumpfile("MultiCycleALU.vcd");
        $dumpvars(0,MultiCycleALU_tb);
        // Initialize inputs
        reset = 1;
        start = 0;
        A = 0;
        B = 0;
        Op = 0;

        // Reset the ALU
        #10 reset = 0;

        // Test case 1: Addition (A + B)
        A = 2'b01; B = 2'b10; Op = 2'b00; start = 1; #10;
        start = 0; wait(done); #10;

        // Test case 2: Subtraction (A - B)
        A = 2'b11; B = 2'b01; Op = 2'b01; start = 1; #10;
        start = 0; wait(done); #10;

        // Test case 3: AND (A & B)
        A = 2'b11; B = 2'b10; Op = 2'b10; start = 1; #10;
        start = 0; wait(done); #10;

        // Test case 4: OR (A | B)
        A = 2'b10; B = 2'b01; Op = 2'b11; start = 1; #10;
        start = 0; wait(done); #10;

        $stop;
    end
endmodule
