module instruction_memory(pc,instruction_code);
input [31:0]pc;
output wire [31:0]instruction_code;

reg [31:0]imem[0:255];

initial begin
$readmemh("program.hex",imem);
end

assign instruction_code = imem[pc>>2]; 
endmodule

/*
here imem is a seperate memory in main memory which only used to store instructions 
and dmem is used to store operand value this technique is used in Harvard Architecture
*/


