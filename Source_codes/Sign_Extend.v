module Sign_Extend #(parameter WIDTH = 32, parameter IMMEDIATE_BITS = 16)
(

input	wire	[IMMEDIATE_BITS-1:0]	Immediate,

output	wire		[WIDTH-1:0]			SignImm
);

assign SignImm = { {16{Immediate[IMMEDIATE_BITS-1]}} ,Immediate[IMMEDIATE_BITS-1:0]} ;

endmodule