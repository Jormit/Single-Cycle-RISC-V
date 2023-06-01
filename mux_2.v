module mux_2 (
	input sel,
	input [31:0] a,
	input [31:0] b,
	output reg [31:0] y
);

	always @(*) begin
		case(sel)
			1'b0: y = a;
			1'b1: y = b;
		endcase
	end
endmodule
