module MUX #(parameter WIDTH = 32)
(

input	wire		[WIDTH-1:0]		in1,
input	wire		[WIDTH-1:0]		in2,
input	wire						sel,

output	reg		[WIDTH-1:0]		out
);

always @(*)
 begin
	if (sel)	out = in1 ;
	else		out = in2 ;
 end

endmodule