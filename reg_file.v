module reg_file (
	input  clock,
	input  write,
	input  [4:0]  reg_1_sel,
	input  [4:0]  reg_2_sel,	
	input  [4:0]  write_reg,
	input  [31:0] write_data,
	output [31:0] reg_1_data,
	output [31:0] reg_2_data
);
	reg [31:0] registers [31:0];

	initial registers [0] = 32'b0;
	
	assign reg_1_data = registers [reg_1_sel];
	assign reg_2_data = registers [reg_2_sel];

	always @(posedge clock) begin
		if (write && write_reg != 5'b0) begin
			registers [write_reg] <= write_data;
		end
	end

endmodule
