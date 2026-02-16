module reg_32(
    sr1,sr2,rd1,rd2,dr,write,wrdata,reset,clk
);

input [4:0] sr1;
input [4:0] sr2;
input [4:0] dr;
input write;
input reset;
input clk;
input [31:0] wrdata;

output [31:0] rd1;
output [31:0] rd2;

reg [31:0] regfile[0:31];

assign rd1 = regfile[sr1];
assign rd2 = regfile[sr2];

integer i;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        for(i=0; i<32; i=i+1)
            regfile[i] <= 0;
    end
    else if(write && dr!=0)
        regfile[dr] <= wrdata;
end

endmodule
