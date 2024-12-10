module allgate_test;   
  reg a, b;   
  wire y1;    

  allgate uut(
    .a(a),   
    .b(b),   
    .y1(y1)
  );   

  integer i = 0;   

  initial begin     

    $dumpfile("allgate.vcd");     
    $dumpvars(0, allgate_test);     

    for(i = 0; i < 4; i = i + 1) begin       
      {a, b} = i;      

      #10;  
    end     
    $finish;   
  end   

endmodule
