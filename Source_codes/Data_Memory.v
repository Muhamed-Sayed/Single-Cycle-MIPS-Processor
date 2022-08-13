module Data_Memory #(parameter WIDTH = 32, parameter DIPTH = 100, parameter ADDR_BITS = 32)
(
input	wire						CLK,
input	wire						RST,
input	wire	[WIDTH-1:0]			A,
input	wire	[WIDTH-1:0]			WD,
input	wire						WE,

output	wire	[WIDTH-1:0] 		RD,
output	wire	[15:0] 				test_value

);

reg		[WIDTH-1:0] 	RAM		[DIPTH-1:0] ;

integer i ;

always @(posedge CLK or negedge RST)
 begin
	if (!RST)
	 begin
		for (i=0; i<DIPTH; i=i+1)
		 begin
			RAM[i] <= 'b0 ;
		 end
	 end
	else if (WE)
	 begin
		RAM[A] <= WD ;
	 end
 end

assign RD = RAM[A] ;

assign test_value = RAM[0][15:0] ;

endmodule