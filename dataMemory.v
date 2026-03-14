module datMemory(clk,MemRead,MemWrite,addr,write_data,mem_data);
    input clk;
    input MemRead;
    input MemWrite;
    input [31:0] addr;
    input [31:0] write_data;
    output reg [31:0] mem_data;

    reg [31:0]memory[0:255];

//store
    always@(posedge clk) begin
      if(MemWrite)
      memory[addr>>2]<=write_data;
    end

//load
    always@(*) begin // why we dont use posedge here -> beacuse if we do it will take 2 cycle first read memory then in second cycle load extra delay and our cpu is a single cycle processor
      if(MemRead)
      mem_data=memory[addr>>2];
      else
      mem_data=32'b0;
    end

endmodule
