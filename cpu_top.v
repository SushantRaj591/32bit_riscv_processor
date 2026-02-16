module cpu_top(
    input clk,
    input reset
);


// WIRES

wire [31:0] pc, next_pc;
wire [31:0] instr;

wire RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, Branch;
wire [1:0] ALUOp;
wire [2:0] immSel;

wire [31:0] rd1, rd2;
wire [31:0] immValue;
wire [31:0] alu_in2;
wire [31:0] y;
wire [31:0] mem_data;
wire [31:0] write_data;
wire [2:0]ctrl;

wire zero;

// PC LOGIC (adders + mux)


wire [31:0] pc_plus4;
wire [31:0] branch_addr;
wire branch_taken;

assign pc_plus4    = pc + 32'd4;
assign branch_addr = pc + immValue;
assign branch_taken = Branch & zero;

assign next_pc = branch_taken ? branch_addr : pc_plus4;

pc PC0(
    .clk(clk),
    .reset(reset),
    .next_pc(next_pc),
    .pc(pc)
);


// INSTRUCTION MEMORY


instruction_memory IM(
    .pc(pc),
    .instruction_code(instr)
);


// CONTROL UNIT

controlUnit CU(
    .instruction_code(instr),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemToReg(MemToReg),
    .Branch(Branch),
    .ALUOp(ALUOp),
    .immSel(immSel)
);


// IMMEDIATE GENERATOR


immGenerator IG(
    .instruction_code(instr),
    .immSel(immSel),
    .immValue(immValue)
);

// REGISTER FILE


reg_32 RF(
    .sr1(instr[19:15]),
    .sr2(instr[24:20]),
    .dr(instr[11:7]),
    .rd1(rd1),
    .rd2(rd2),
    .write(RegWrite),
    .wrdata(write_data),
    .clk(clk),
    .reset(reset)
);

// ALU SOURCE MUX


assign alu_in2 = ALUSrc ? immValue : rd2;

//ALU CONTROL

aluControl AC(
    .ALUOp(ALUOp),
    .funct3(instr[14:12]),
    .funct7(instr[31:25]),
    .ctrl(ctrl)
);

// ALU


alu ALU0(
    .A(rd1),
    .B(alu_in2),
    .ctrl(ctrl),
    .y(y),
    .z(zero)
);


// DATA MEMORY


datMemory DM(
    .clk(clk),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .addr(y),
    .write_data(rd2),
    .mem_data(mem_data)
);

// WRITEBACK MUX


assign write_data = MemToReg ? mem_data : y;

endmodule
