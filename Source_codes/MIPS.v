module MIPS #(
parameter WIDTH = 32,
parameter ADDR_BITS = 5, 
parameter IMMEDIATE_BITS = 16, 
parameter TARGET_ADD_BITS = 26, 
parameter REG_FILE_DEPTH = 100, 
parameter DATA_MEM_DEPTH = 100,  
parameter INSTR_MEM_DEPTH = 100 
)
(
input	wire						CLK,
input	wire						RST,

output	wire	[15:0] 				test_value
);

wire							Jump, RegWrite, MemtoReg, PCSrc, ALUSrc, RegDst ,Zero_Flag, DataMem_Write_En ;		
wire	[2:0]					ALUControl ;
wire	[WIDTH-1:0] 			ALUOut, WriteData ,ReadData, PC, Instr ;


Control_Unit 		CU_U1
(

.Funct(Instr[5:0]),
.Opcode(Instr[31:26]),
.Zero(Zero_Flag),

.Jump(Jump),
.MemtoReg(MemtoReg),
.PCSrc(PCSrc),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.ALUControl(ALUControl),
.MemWrite(DataMem_Write_En)
);

Data_Memory #(.WIDTH(WIDTH), .ADDR_BITS(ADDR_BITS), .DIPTH(DATA_MEM_DEPTH) )	DATA_MEM_U1	
(
.CLK(CLK),
.RST(RST),
.A(ALUOut),
.WD(WriteData),
.WE(DataMem_Write_En),

.RD(ReadData),
.test_value(test_value)

);


Instruction_Memory #(.WIDTH(WIDTH), .DEPTH(INSTR_MEM_DEPTH))		Instr_Mem_U1
(
.PC(PC),
.Instr(Instr)
);


Datapath #(.WIDTH(WIDTH), .ADDR_BITS(ADDR_BITS), .IMMEDIATE_BITS(IMMEDIATE_BITS), .TARGET_ADD_BITS(TARGET_ADD_BITS), .REG_FILE_DEPTH(REG_FILE_DEPTH))		Datapath_U1
(
.CLK(CLK),
.RST(RST),
.Jump(Jump),
.MemtoReg(MemtoReg),
.PCSrc(PCSrc),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.ALUControl(ALUControl),
.ReadData(ReadData),
//Instruction Fields rs and rt and rd and immediate field
.Rs_Address(Instr[25:21]),
.Rt_Address(Instr[20:16]),
.Rd_Address(Instr[15:11]),
.Immediate_val(Instr[15:0]),
.Target_address(Instr[25:0]),


.Zero_Flag(Zero_Flag),
.PC(PC),
.ALUOut(ALUOut),
.WriteData(WriteData)

);




endmodule