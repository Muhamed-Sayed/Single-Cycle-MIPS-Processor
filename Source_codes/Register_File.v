module Register_File #(parameter WIDTH = 32, parameter DIPTH = 100, parameter ADDR_BITS = 5)
(
input	wire						CLK,
input	wire						RST,
input	wire	[ADDR_BITS-1:0]		A1,
input	wire	[ADDR_BITS-1:0]		A2,
input	wire	[ADDR_BITS-1:0]		A3,
input	wire	[WIDTH-1:0]			WD3,
input	wire						WE3,

output	wire	[WIDTH-1:0] 		RD1,
output	wire	[WIDTH-1:0] 		RD2

);

reg		[WIDTH-1:0] 	Reg_File	[DIPTH-1:0] ;

integer i ;

always @(posedge CLK or negedge RST)
 begin
	if (!RST)
	 begin
		for (i=0; i<DIPTH; i=i+1)
		 begin
			Reg_File[i] <= 'b0 ;
		 end
	 end
	else if (WE3)
	 begin
		Reg_File[A3] <= WD3 ;
	 end
 end

assign RD1 = Reg_File[A1] ;

assign RD2 = Reg_File[A2] ;

endmodule