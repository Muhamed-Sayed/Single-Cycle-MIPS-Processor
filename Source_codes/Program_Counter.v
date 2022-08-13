module Program_Counter #(parameter WIDTH = 32)
(
input	wire					CLK,
input	wire					RST,
input	wire	[WIDTH-1:0]		PC_in,
output	reg		[WIDTH-1:0] 	PC
);


always @(posedge CLK or negedge RST)
 begin
	if (!RST)
	 begin
		PC <= 'b0 ;
	 end
	else
	 begin
		PC <= PC_in ;
	 end
 end

endmodule