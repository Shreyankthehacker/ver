`timescale 1ns / 1ps

module ALU_2bit_tb;
    // Inputs
    reg [1:0] A;
    reg [1:0] B;
    reg [1:0] Op;

    // Outputs
    wire [2:0] Y;

    // Instantiate the Unit Under Test (UUT)
    ALU_2bit uut (
        .A(A),
        .B(B),
        .Op(Op),
        .Y(Y)
    );

    initial begin
        $dumpfile("ALU_2bit.vcd");
        $dumpvars(0,ALU_2bit_tb);
        // Test cases
        $monitor("Time=%0t, A=%b, B=%b, Op=%b, Y=%b", $time, A, B, Op, Y);

        // Test case 1: Addition
        A = 2'b01; B = 2'b10; Op = 2'b00; #10;

        // Test case 2: Subtraction
        A = 2'b10; B = 2'b01; Op = 2'b01; #10;

        // Test case 3: AND
        A = 2'b11; B = 2'b01; Op = 2'b10; #10;

        // Test case 4: OR
        A = 2'b10; B = 2'b01; Op = 2'b11; #10;

        // Test case 5: Default
        A = 2'b10; B = 2'b01; Op = 2'bxx; #10;

        $stop;
    end
endmodule
