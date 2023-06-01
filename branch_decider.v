`include "defines.v"

module branch_decider (
	input branch,
	input jump,
	input [2:0] funct3,
	input alu_zero,
	output reg pc_source
);
	reg take_branch;
	always @(funct3) begin
		case (funct3)
			`FUNCT3_BRANCH_EQ:  take_branch = !alu_zero;
			`FUNCT3_BRANCH_NE:  take_branch = alu_zero;
			`FUNCT3_BRANCH_LT:  take_branch = !alu_zero;
			`FUNCT3_BRANCH_GE:  take_branch = alu_zero;
			`FUNCT3_BRANCH_LTU: take_branch = !alu_zero;
			`FUNCT3_BRANCH_GEU: take_branch = alu_zero;
			default: take_branch = 1'bx;
		endcase
	end

	always @(jump, branch, take_branch) begin
		if (jump && !branch)            pc_source <= `PC_ALU_RESULT;
		else if (branch && take_branch) pc_source <= `PC_BRANCH_OFFSET;
		else                            pc_source <= `PC_NEXT_INST;
	end
endmodule
