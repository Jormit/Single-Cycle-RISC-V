`include "defines.v"

module control (
	input [6:0] opcode,
	output reg bus_read,
	output reg bus_write,
	output reg bus_to_reg,
	output reg reg_write,
	output reg alu_src_1,
	output reg alu_src_2,
	output reg out_sel,
	output reg branch,
	output reg jump,
	output reg [1:0] alu_op
);
	always @(*) begin
		case (opcode)
			`OPCODE_LOAD:
			begin
				bus_read   <= 1'b1;
				bus_write  <= 1'b0;
				bus_to_reg <= 1'b1;
				reg_write  <= 1'b1;
				alu_src_1  <= `CTL_ALU_1_RS1;
				alu_src_2  <= `CTL_ALU_2_IMM;
				out_sel	   <= `CTL_ALU;
				branch     <= 1'b0;
				jump       <= 1'b0;
				alu_op     <= `CTL_ALU_ADD;
			end
			`OPCODE_OP_IMM:
			begin
				bus_read   <= 1'b0;
				bus_write  <= 1'b0;
				bus_to_reg <= 1'b0;
				reg_write  <= 1'b1;
				alu_src_1  <= `CTL_ALU_1_RS1;
				alu_src_2  <= `CTL_ALU_2_IMM;
				out_sel	   <= `CTL_ALU;
				branch     <= 1'b0;
				jump       <= 1'b0;
				alu_op     <= `CTL_ALU_OP_IMM;				
			end
			`OPCODE_AUIPC:
			begin
				bus_read   <= 1'b0;
				bus_write  <= 1'b0;
				bus_to_reg <= 1'b0;
				reg_write  <= 1'b1;
				alu_src_1  <= `CTL_ALU_1_PC;
				alu_src_2  <= `CTL_ALU_2_IMM;
				out_sel	   <= `CTL_ALU;
				branch     <= 1'b0;
				jump       <= 1'b0;
				alu_op     <= `CTL_ALU_ADD;
			end				
			`OPCODE_STORE:
			begin
				bus_read   <= 1'b0;
				bus_write  <= 1'b1;
				bus_to_reg <= 1'b0;
				reg_write  <= 1'b0;
				alu_src_1  <= `CTL_ALU_1_RS1;
				alu_src_2  <= `CTL_ALU_2_IMM;
				out_sel	   <= `CTL_ALU;
				branch     <= 1'b0;	
				jump       <= 1'b0;
				alu_op     <= `CTL_ALU_ADD;				
			end
			`OPCODE_OP:
			begin
				bus_read   <= 1'b0;
				bus_write  <= 1'b0;
				bus_to_reg <= 1'b0;
				reg_write  <= 1'b1;
				alu_src_1  <= `CTL_ALU_1_RS1;
				alu_src_2  <= `CTL_ALU_2_RS2;
				out_sel	   <= `CTL_ALU;
				branch     <= 1'b0;
				jump       <= 1'b0;
				alu_op     <= `CTL_ALU_OP;				
			end
			`OPCODE_LUI:
			begin
				bus_read   <= 1'b1;
				bus_write  <= 1'b0;
				bus_to_reg <= 1'b0;
				reg_write  <= 1'b1;
				alu_src_1  <= `CTL_ALU_1_RS1;
				alu_src_2  <= `CTL_ALU_2_RS2;
				out_sel	   <= `CTL_IMM;
				branch     <= 1'b0;
				jump       <= 1'b0;
				alu_op     <= `CTL_ALU_OP;				
			end
			`OPCODE_BRANCH:
			begin
				bus_read   <= 1'b0;
				bus_write  <= 1'b0;
				bus_to_reg <= 1'b0;
				reg_write  <= 1'b0;
				alu_src_1  <= `CTL_ALU_1_RS1;
				alu_src_2  <= `CTL_ALU_2_RS2;
				out_sel	   <= `CTL_ALU;
				branch     <= 1'b1;
				jump       <= 1'b0;
				alu_op     <= `CTL_ALU_BRANCH;			
			end
			`OPCODE_JALR:
			begin
				bus_read   <= 1'b0;
				bus_write  <= 1'b0;
				bus_to_reg <= 1'b0;
				reg_write  <= 1'b1;
				alu_src_1  <= `CTL_ALU_1_RS1;
				alu_src_2  <= `CTL_ALU_2_IMM;
				out_sel	   <= `CTL_ALU;
				branch     <= 1'b0;
				jump       <= 1'b1;
				alu_op     <= `CTL_ALU_ADD;				
			end
			`OPCODE_JAL:
			begin
				bus_read   <= 1'b0;
				bus_write  <= 1'b0;
				bus_to_reg <= 1'b0;
				reg_write  <= 1'b1;
				alu_src_1  <= `CTL_ALU_1_PC;
				alu_src_2  <= `CTL_ALU_2_IMM;
				out_sel	   <= `CTL_ALU;
				branch     <= 1'b0;
				jump       <= 1'b1;
				alu_op     <= `CTL_ALU_ADD;				
			end	
		endcase
	end
endmodule
