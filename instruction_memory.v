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


// ------------------------------------------------------------
// PROGRAM COUNTER (PC) ADDRESSING NOTE
//
// PC stores BYTE address, not instruction number.
// Each instruction is 32 bits = 4 bytes.
//
// Instruction memory is WORD-indexed, so we must convert
// byte address -> word index.
//
// Conversion:
//   word_index = pc / 4
//   Since 4 = 2^2, division by 4 is implemented as right shift.
//
// Therefore:
//   pc >> 2   // correct instruction index
//
// Example:
//   PC = 0   -> instruction 0
//   PC = 4   -> instruction 1
//   PC = 8   -> instruction 2
//
//  Here pc gives byte address of instruction in imem.Each instruction has 32 bits 

// pc[1:0] are always 00 for aligned instructions.
// ------------------------------------------------------------
