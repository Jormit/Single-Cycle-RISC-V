module pc (
	input      clock,
	input      write,
	input      [31:0] data,
	output reg [31:0] pc
);

	always @(posedge clock) begin
		if (write) pc <= data;
		else       pc <= pc + 4;
	end

endmodule
