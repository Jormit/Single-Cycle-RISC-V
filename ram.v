module ram 
#(parameter SIZE = 256) (
	input  clock,
	input  write,
	input  [31:0] write_data,
	input  [31:0] address,
	output [31:0] data
);
	reg [31:0] mem [0 : SIZE - 1];      
	assign data = address[31:2] < SIZE ? mem[address[31:2]] : 32'b0;

	always @(posedge clock) begin
		if (write && address[31:2] < SIZE) begin
			mem [address] = write_data;
		end
	end

endmodule
