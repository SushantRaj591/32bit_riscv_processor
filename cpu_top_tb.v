`timescale 1ns/1ps

module cpu_top_tb;

reg clk;
reg reset;

cpu_top uut(.clk(clk), .reset(reset));


initial clk = 0;
always #5 clk = ~clk;


initial begin
    $dumpfile("cpu_wave.vcd");
    $dumpvars(0, cpu_top_tb);
    reset =1;
    #20 reset=0;
    #300 $finish;
end

initial begin
    $monitor("t=%0t pc=%h instr=%h y=%h mem_data=%h",
              $time, uut.pc, uut.instr, uut.y, uut.mem_data);
end

initial begin
    reset = 1;
    #20 reset = 0;

    #1000;

    $display("\nFINAL REGISTERS:");
    $display("x1=%0d x2=%0d x3=%0d x4=%0d",
             uut.RF.regfile[1],
             uut.RF.regfile[2],
             uut.RF.regfile[3],
             uut.RF.regfile[4]);

    $finish;
end

endmodule
