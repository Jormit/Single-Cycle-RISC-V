module rom
#(parameter SIZE = 256)
(
	input  [31:0] address,
	output [31:0] data
);

	reg [31:0] mem [0 : SIZE - 1];      
	assign data = address < SIZE ? mem[address] : 32'b0;

	initial begin
  		$readmemh("inst.txt", mem, 0, 255);
	end

endmodule
