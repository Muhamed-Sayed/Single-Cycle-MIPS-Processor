module Main_Decoder 
(

input	wire	[5:0]	Opcode,

output	reg				Jump,
output	reg				MemtoReg,
output	reg				MemWrite,
output	reg				Branch,
output	reg				ALUSrc,
output	reg				RegDst,
output	reg				RegWrite,
output	reg		[1:0]	ALUOp

);

/****************************************************************************************/
/**************************** Opcodes of the instruction set ****************************/
/****************************************************************************************/
localparam	loadWord = 6'b100011,
			storeWord = 6'b101011,
			rType = 6'b000000,
			addImmediate = 6'b001000,
			branchIfEqual = 6'b000100,
			jump_inst = 6'b000010 ;
			

			
always @(*)
 begin
	//initial values
	Jump = 1'b0 ;
	MemtoReg = 1'b0 ;
	MemWrite = 1'b0 ;
	Branch = 1'b0 ;
	ALUSrc = 1'b0 ;
	RegDst = 1'b0 ;
	RegWrite = 1'b0 ;
	ALUOp = 2'b00 ;
	
	
	case (Opcode)
	
	loadWord : 	
	 begin
		Jump = 1'b0 ;
		MemtoReg = 1'b1 ;
		MemWrite = 1'b0 ;
		Branch = 1'b0 ;
		ALUSrc = 1'b1 ;
		RegDst = 1'b0 ;
		RegWrite = 1'b1 ;
		ALUOp = 2'b00 ;
	 end
	
	storeWord :  
	 begin
		Jump = 1'b0 ;
		MemtoReg = 1'b1 ;
		MemWrite = 1'b1 ;
		Branch = 1'b0 ;
		ALUSrc = 1'b1 ;
		RegDst = 1'b0 ;
		RegWrite = 1'b0 ;
		ALUOp = 2'b00 ;
	 end
	
	rType : 	  
	 begin
		Jump = 1'b0 ;
		MemtoReg = 1'b0 ;
		MemWrite = 1'b0 ;
		Branch = 1'b0 ;
		ALUSrc = 1'b0 ;
		RegDst = 1'b1 ;
		RegWrite = 1'b1 ;
		ALUOp = 2'b10 ;
	 end
	
	addImmediate : 	
	 begin
		Jump = 1'b0 ;
		MemtoReg = 1'b0 ;
		MemWrite = 1'b0 ;
		Branch = 1'b0 ;
		ALUSrc = 1'b1 ;
		RegDst = 1'b0 ;
		RegWrite = 1'b1 ;
		ALUOp = 2'b00 ;
	 end
	
	branchIfEqual :  
	 begin
		Jump = 1'b0 ;
		MemtoReg = 1'b0 ;
		MemWrite = 1'b0 ;
		Branch = 1'b1 ;
		ALUSrc = 1'b0 ;
		RegDst = 1'b0 ;
		RegWrite = 1'b0 ;
		ALUOp = 2'b01 ;
	 end
	
	jump_inst : 	
	 begin
		Jump = 1'b1 ;
		MemtoReg = 1'b0 ;
		MemWrite = 1'b0 ;
		Branch = 1'b0 ;
		ALUSrc = 1'b0 ;
		RegDst = 1'b0 ;
		RegWrite = 1'b0 ;
		ALUOp = 2'b00 ;
	 end
	
	default	:
	 begin
		Jump = 1'b0 ;
		MemtoReg = 1'b0 ;
		MemWrite = 1'b0 ;
		Branch = 1'b0 ;
		ALUSrc = 1'b0 ;
		RegDst = 1'b0 ;
		RegWrite = 1'b0 ;
		ALUOp = 2'b00 ;
	 end
	
	endcase
	
 end
endmodule