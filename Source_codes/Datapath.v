module Datapath #(parameter WIDTH = 32, parameter ADDR_BITS = 5, parameter IMMEDIATE_BITS = 16, parameter TARGET_ADD_BITS = 26, parameter REG_FILE_DEPTH = 100)
(
input	wire						CLK,
input	wire						RST,
input	wire						Jump,
input	wire						MemtoReg,
input	wire						PCSrc,
input	wire						ALUSrc,
input	wire						RegDst,
input	wire						RegWrite,
input	wire	[2:0]				ALUControl,
input	wire	[WIDTH-1:0]			ReadData,
//Instruction Fields rs and rt and rd and immediate field
input	wire	[ADDR_BITS-1:0]		Rs_Address,
input	wire	[ADDR_BITS-1:0]		Rt_Address,
input	wire	[ADDR_BITS-1:0]		Rd_Address,
input	wire	[IMMEDIATE_BITS-1:0]	Immediate_val,
input	wire	[TARGET_ADD_BITS-1:0]	Target_address,


output	wire						Zero_Flag,
output	wire	[WIDTH-1:0] 		PC,
output	wire	[WIDTH-1:0] 		ALUOut,
output	wire	[WIDTH-1:0] 		WriteData

);

wire	[ADDR_BITS-1:0]		WriteReg_Address ;
wire	[WIDTH-1:0]			WriteReg_Data ;
wire	[WIDTH-1:0]			ALUSrcA ;
wire	[WIDTH-1:0]			ALUSrcB ;	
wire	[WIDTH-1:0]			SignImm ;	
wire	[WIDTH-1:0]			shift_left_out1 ;
wire	[WIDTH-1:0]			PCBranch ;
wire	[WIDTH-1:0]			PCPlus4, PC_in, PC_in_mux1 ;
wire	[TARGET_ADD_BITS+1:0]				shift_left_out2 ;

Register_File #(.WIDTH(WIDTH), .DIPTH(REG_FILE_DEPTH), .ADDR_BITS(ADDR_BITS))	RegFile_U1
(
.CLK(CLK),
.RST(RST),
.A1(Rs_Address),
.A2(Rt_Address),
.A3(WriteReg_Address),
.WD3(WriteReg_Data),
.WE3(RegWrite),

.RD1(ALUSrcA),
.RD2(WriteData)

);

MUX #(.WIDTH(WIDTH))	ALUSrcB_MUX
(

.in1(SignImm),
.in2(WriteData),
.sel(ALUSrc),

.out(ALUSrcB)
);

MUX #(.WIDTH(ADDR_BITS))	WriteRegAddress_Mux
(

.in1(Rd_Address),
.in2(Rt_Address),
.sel(RegDst),

.out(WriteReg_Address)
);

MUX #(.WIDTH(WIDTH))	WriteRegData_Mux
(

.in1(ReadData),
.in2(ALUOut),
.sel(MemtoReg),

.out(WriteReg_Data)
);


ALU #(.WIDTH(WIDTH))	ALU_U1
(
.SrcA(ALUSrcA),
.SrcB(ALUSrcB),
.ALUControl(ALUControl),

.ALUResult(ALUOut),
.Zero(Zero_Flag)

);


Sign_Extend #(.WIDTH(WIDTH), .IMMEDIATE_BITS(IMMEDIATE_BITS))	Sign_Extend_U1
(

.Immediate(Immediate_val),

.SignImm(SignImm)
);

shift_left_twice #(.WIDTH(WIDTH))	shift_left_signed_immediate
(

.in_data(SignImm),

.out_data(shift_left_out1)
);

Adder #(.WIDTH(WIDTH))			PCBranch_Adder
(

.A(shift_left_out1),
.B(PCPlus4),

.C(PCBranch)
);

shift_left_twice #(.WIDTH(TARGET_ADD_BITS+2))	shift_left_target_address
(

.in_data({2'b00,Target_address}),

.out_data(shift_left_out2)
);

Adder #(.WIDTH(WIDTH))			PCPlus4_Adder
(

.A(PC),
.B(32'd4),

.C(PCPlus4)
);

Program_Counter #(.WIDTH(WIDTH))	PC_U1
(
.CLK(CLK),
.RST(RST),
.PC_in(PC_in),
.PC(PC)
);

MUX #(.WIDTH(WIDTH))	PC_in_MUX1
(

.in1(PCBranch),
.in2(PCPlus4),
.sel(PCSrc),

.out(PC_in_mux1)
);

MUX #(.WIDTH(WIDTH))	PC_in_MUX2
(

.in1({{PCPlus4[31:28]},{shift_left_out2[27:0]}}),
.in2(PC_in_mux1),
.sel(Jump),

.out(PC_in)
);
endmodule