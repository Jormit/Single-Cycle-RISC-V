`include "defines.v"

module alu (
	input  [4:0]  operation,
	input signed  [31:0] operand_1,
	input signed  [31:0] operand_2,
	output reg [31:0] result
);

	always @(*) begin
		case (operation)
			`ALU_ADD: result <= operand_1 + operand_2;
			`ALU_SUB: result <= operand_1 - operand_2;
			`ALU_SLL: result <= operand_1 << operand_2[4:0];
			`ALU_SRL: result <= operand_1 >> operand_2[4:0];
			`ALU_SRA: result <= operand_1 >>> operand_2[4:0];
			`ALU_EQ:  result <= {31'b0, operand_1 == operand_2};
			`ALU_LT:  result <= {31'b0, operand_1 <  operand_2};
			`ALU_LTU: result <= {31'b0, $unsigned(operand_1) <  $unsigned(operand_2)};
			`ALU_XOR: result <= operand_1 ^ operand_2;
			`ALU_OR:  result <= operand_1 | operand_2;
			`ALU_AND: result <= operand_1 & operand_2;
			default:  result <= 32'b0;			
		endcase
	end
endmodule
