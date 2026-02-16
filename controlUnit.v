module controlUnit(instruction_code,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,Branch,Jump,ALUOp,immSel);

input [31:0]instruction_code;
output reg RegWrite;
output reg ALUSrc;
output reg MemRead;
output reg MemToReg;
output reg MemWrite;
output reg Branch;
output reg Jump;
output reg [1:0]ALUOp; // will be used as input in ALU control unit 
output reg [2:0]immSel;
wire [6:0]opcode;
assign opcode = instruction_code[6:0];


always @(*)
begin
RegWrite=0;
       ALUSrc=0;
       MemRead=0;
       MemWrite=0;
       MemToReg=0;
       Branch=0;
       Jump=0;
       ALUOp=2'b00;
       immSel=3'b000;
case(opcode)
7'b0110011 :begin
       RegWrite=1;
       ALUSrc=0;
       MemRead=0;
       MemWrite=0;
       MemToReg=0;
       Branch=0;
       Jump=0;
       ALUOp=2'b10;
        end
7'b0010011  :begin
        RegWrite=1;
       ALUSrc=1;
       MemRead=0;
       MemWrite=0;
       MemToReg=0;
       Branch=0;
       Jump=0;
       ALUOp=2'b10;
       immSel = 3'b001;
       end
7'b0000011 :begin
        RegWrite=1;
       ALUSrc=1;
       MemRead=1;
       MemWrite=0;
       MemToReg=1;
       Branch=0;
       Jump=0;
       ALUOp=2'b00;
        immSel = 3'b001;
        end
7'b0100011 :begin
         RegWrite=0;
       ALUSrc=1;
       MemRead=0;
       MemWrite=1;
       MemToReg=1'b0;//dont care
       Branch=0;
       Jump=0;
       ALUOp=2'b00;
        immSel = 3'b010;
        end
7'b1100011 :begin
      RegWrite=0;
       ALUSrc=0;
       MemRead=0;
       MemWrite=0;
       MemToReg=1'b0;//dont care
       Branch=1;
       Jump=0;
       ALUOp=2'b01;
        immSel = 3'b011;
        end
/*7'b1101111 :begin
      RegWrite=1;
       ALUSrc=1'b0;//dont care
       MemRead=0;
       MemWrite=0;
       MemToReg=1'b0;//dont care
       Branch=0;
       Jump=1;
       ALUOp=2'b00;//dont care
       immSel = 3'b101;
        end*/
default : begin 
       RegWrite=0;
       ALUSrc=0;
       MemRead=0;
       MemWrite=0;
       MemToReg=0;
       Branch=0;
       Jump=0;
       ALUOp=2'b00;
         end
endcase
end
endmodule

//We dont use 2'bxx as dont care instead put it as 2'b00 becuase it is more practicle and robust