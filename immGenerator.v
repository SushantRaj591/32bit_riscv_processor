module immGenerator(instruction_code,immSel,immValue);
//immediate value is taken from instr code but for diff instr, immediate value are stored at diff places in instr code 
//immSel is used to define the type of instruction so we can get immediate value as immediate value are stored at diff places in instr code 
//immSel is decided by opcode and it is used to decide type of instr ,though this can also be done by opcode but for more better and efficient use we use immSel
//000 ->R type ,001 ->I type ,010 -> S type , 011->B type,100->U type,101 ->J type 
input [31:0]instruction_code;
input [2:0]immSel;
output reg [31:0]immValue;//immediate value 
always@(*)begin
case(immSel)
3'b000:immValue=32'b0;
3'b001:immValue={{20{instruction_code[31]}},
                instruction_code[31:20]};

3'b010:immValue={{20{instruction_code[31]}},
                 instruction_code[31:25],
                 instruction_code[11:7]};

3'b011:immValue={{19{instruction_code[31]}},
instruction_code[31], instruction_code[7],
 instruction_code[30:25], 
 instruction_code[11:8], 1'b0};

//3'b100:immValue= { instruction_code[31:12],12'b0 };

//3'b101:immValue={ {{11{instruction_code[31]}},instruction_code[31], instruction_code[19:12], instruction_code[20], instruction_code[30:21], 1'b0 } };

default:immValue=32'b0;
endcase
end
endmodule
