module aluControl(ALUOp,funct3,funct7,ctrl);
input [1:0]ALUOp;
input [2:0]funct3;
input [6:0]funct7;
output reg [2:0]ctrl;

always @(*) begin
case(ALUOp) 
2'b00:ctrl=3'b000;
2'b01:ctrl=3'b001;
2'b10: begin 
  case(funct3)
  3'b000 :ctrl =funct7[5] ? 3'b001:3'b000;
  3'b111 :ctrl =3'b010;
  3'b110 :ctrl =3'b011;
  3'b100 :ctrl =3'b100;
  3'b010 :ctrl=3'b101;
  default :ctrl = 3'b000;
  endcase
  end
2'b11: begin
  case(funct3)
  3'b000 :ctrl =3'b000;
  3'b111 :ctrl =3'b010;
  3'b110 :ctrl =3'b011;
  3'b100 :ctrl =3'b100;
  3'b010 :ctrl=3'b101;
  default :ctrl =3'b000;
  endcase
  end
  default : ctrl=3'b000;
  endcase
end
endmodule