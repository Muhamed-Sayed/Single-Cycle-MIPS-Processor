
module ALU_Decoder 
(

input	wire	[5:0]	Funct,
input	wire	[1:0]	ALUOp,

output	reg		[2:0]	ALUControl

);



/****************************************************************************************/
/******************************* Funct field machine codes ******************************/
/****************************************************************************************/
localparam	add = 6'b100000,
			sub = 6'b100010,
			slt = 6'b101010,
			mul = 6'b011100 ;

always @(*)
 begin
	//initial values
	
	ALUControl = 3'b000 ;
	
	
	case (ALUOp)
	
	2'b00 : 	
	 begin
		ALUControl = 3'b010 ;
	 end
	
	2'b01 :  
	 begin
		ALUControl = 3'b100 ;
	 end
	
	2'b10 : 	  
	 begin
		case (Funct)
			add : ALUControl = 3'b010 ;
			sub : ALUControl = 3'b100 ;
			slt : ALUControl = 3'b110 ;
			mul : ALUControl = 3'b101 ;
			default : ALUControl = 3'b010 ;
		endcase
	 end
	
	2'b11 : 	
	 begin
		ALUControl = 3'b010 ;
	 end
	
	default	:
	 begin
		ALUControl = 3'b010 ;
	 end
	
	endcase
	
 end
endmodule