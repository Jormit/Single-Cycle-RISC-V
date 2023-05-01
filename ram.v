module ram 
#(parameter SIZE = 256) (
	input  clk,
	input  write,
	input  [31:0] write_data,
	input  [31:0] address,
	output [31:0] data
);
	reg [31:0] mem [0 : SIZE - 1];      
	assign data = address < SIZE ? mem[address] : 32'b0;

	always @(posedge clk) begin
		if (write && address < SIZE) begin
			mem [address] = write_data;
		end
	end

endmodule
