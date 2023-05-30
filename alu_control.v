`include "defines.v"

module alu_control (
	input  [1:0] alu_op,
	input  [2:0] funct3,
    input  [6:0] funct7,
	output reg [3:0] operation
);

	reg [3:0] branch_funct;
	reg [3:0] primary_op_funct;
	reg [3:0] secondary_op_funct;
	reg [3:0] op_funct;
	reg [3:0] op_imm_funct;

	always @(*) begin
		case (alu_op)
			`CTL_ALU_ADD:    operation <= `ALU_ADD;
			`CTL_ALU_BRANCH: operation <= branch_funct;
			`CTL_ALU_OP:     operation <= op_funct;
			`CTL_ALU_OP_IMM: operation <= op_imm_funct;
			default:         branch_funct <= 4'bx;
		endcase
		
		case (funct3)
			`FUNCT3_BRANCH_EQ:	branch_funct <= `ALU_EQ;
			`FUNCT3_BRANCH_NE:	branch_funct <= `ALU_EQ;
			`ALU_LT:         	branch_funct <= `ALU_LT;
			`FUNCT3_BRANCH_GE:	branch_funct <= `ALU_LT;
			`FUNCT3_BRANCH_LTU:	branch_funct <= `ALU_LTU;
			`FUNCT3_BRANCH_GEU:	branch_funct <= `ALU_LTU;
			default:            branch_funct <= 4'bx;
		endcase

		case (funct3)
			`FUNCT3_ALU_ADD_SUB: primary_op_funct <= `ALU_ADD;
			`FUNCT3_ALU_SL:      primary_op_funct <= `ALU_SLL;
			`FUNCT3_ALU_LT:      primary_op_funct <= `ALU_LT;
			`FUNCT3_ALU_LTU:     primary_op_funct <= `ALU_LTU;
			`FUNCT3_ALU_XOR:     primary_op_funct <= `ALU_XOR;
			`FUNCT3_ALU_SR:      primary_op_funct <= `ALU_SRL;
			`FUNCT3_ALU_OR:      primary_op_funct <= `ALU_OR;
			`FUNCT3_ALU_AND:     primary_op_funct <= `ALU_AND;	
			default:             primary_op_funct <= 4'bx;		
		endcase

		case (funct3)
			`FUNCT3_ALU_ADD_SUB: secondary_op_funct <= `ALU_SUB;
			`FUNCT3_ALU_SR:      secondary_op_funct <= `ALU_SRA;
			default:             secondary_op_funct <= 4'bx;		
		endcase


		if (funct7[5]) op_funct = secondary_op_funct;
		else           op_funct = primary_op_funct;

		if (funct7[5] && funct3[1:0] == 2'b01)
			           op_imm_funct = secondary_op_funct;
		else           op_imm_funct = primary_op_funct;
	end
endmodule
