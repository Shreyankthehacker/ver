module allgate_test;
  reg a,b;
  wire s,c;

  half_adder uut(
    .a(a),
    .b(b),
    .s(s),
    .c(c)
  );

  integer i;
  initial begin
    $dumpfile("half_adder.vcd");
    $dumpvars(0,allgate_test);

    for(i=0;i<4;i=i+1)begin
      {a,b} = i;

      #10;
      end
    $finish;
  end
endmodule
    
  