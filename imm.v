module imm (
	input  [31:0] inst,
	output [31:0] imm
);

	always @(*) begin
		case (inst[6:0])
			// I-Type
			`OPCODE_LOAD, 
			`OPCODE_OP_IMM,
			`OPCODE_JALR:   imm = { {21{inst[31]}}, inst[30:20] };

			// S-Type
			`OPCODE_STORE:  imm = { {21{inst[31]}}, inst[30:25], inst[11:7] };
			
			// B-Type
			`OPCODE_BRANCH: imm = { {20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0 };

			// U-Type
			`OPCODE_AUIPC,
			`OPCODE_LUI:    imm = { inst[31:12], 12'b0 };

			// J-Type
			`OPCODE_JAL:    imm = { {12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0 };

			default: immediate = 32'b0;			
		endcase
	end

endmodule
