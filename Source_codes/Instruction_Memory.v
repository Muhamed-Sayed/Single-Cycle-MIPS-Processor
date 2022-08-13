module Instruction_Memory #(parameter WIDTH = 32, parameter DEPTH = 100)
(
input	wire	[WIDTH-1:0]		PC,
output	wire	[WIDTH-1:0] 	Instr
);

reg		[WIDTH-1:0]		ROM		[DEPTH-1:0] ;

assign Instr = ROM [PC>>2] ;

initial 
 begin
	$readmemh ("Program 2_Machine Code.txt", ROM) ;  
 end

endmodule