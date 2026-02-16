module alu(A,B,y,ctrl,z,c,overflow);
/*
ctrl   Function
000    ADD
001    SUB
010    AND
011    OR
100    XOR
101    Compare
110     A
111     B
*/
parameter width =32;
input [width -1:0]A;
input [width -1:0]B;
input [2:0]ctrl;

output z;//zero flag
output reg [width-1:0]y;
output reg c;//carry flag
output reg overflow;//overflow flag

always @(*)
begin
y=1'b0;
c=1'b0;
overflow =1'b0;
case(ctrl)
3'b000 :begin
        {c,y} =A+B;
        overflow =(A[width-1]==B[width-1])&&(y[width-1]!=A[width-1]);
        end
3'b001 :begin
        {c,y} =A+(~B)+1'b1;
        overflow =(A[width-1]!=B[width-1])&&(y[width-1]!=A[width-1]);
        end
3'b010 :begin
        y = A&B;
        end
3'b011 :begin
        y =A|B;
        end
3'b100 :begin
        y=A^B;
        end
3'b101 :begin
        y =($signed(A) < $signed(B)) ? (32'b1) : (32'b0);
        end
3'b110 :begin
        y =A;
        end
3'b111 :begin
        y =B;
        end
default : begin 
        y ={width{1'b0}};
         overflow =0;
         c=0;
         end
endcase
end
assign z = (y=={width{1'b0}});
endmodule