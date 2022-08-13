
module Control_Unit 
(

input	wire	[5:0]	Funct,
input	wire	[5:0]	Opcode,
input	wire			Zero,

output	wire			Jump,
output	wire			MemtoReg,
output	wire			MemWrite,
output	wire			PCSrc,
output	wire			ALUSrc,
output	wire			RegDst,
output	wire			RegWrite,
output	wire	[2:0]	ALUControl

);

wire	[1:0]	ALUOp ; 
wire			Branch ;

Main_Decoder U1(
.Opcode(Opcode),

.Jump(Jump),
.MemtoReg(MemtoReg),
.MemWrite(MemWrite),
.Branch(Branch),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.ALUOp(ALUOp)

);

ALU_Decoder U2(

.Funct(Funct),
.ALUOp(ALUOp),

.ALUControl(ALUControl)
);

And U3(
.A(Branch),
.B(Zero),

.C(PCSrc)
);

endmodule