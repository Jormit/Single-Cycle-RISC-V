module riscv_core (
	input clock,
	input reset,	

	output [31:0] bus_address,
	output [31:0] bus_write_data,
	input  [31:0] bus_read_data,
	output bus_write,	
	output bus_read,

	input [31:0] inst,
	output reg [31:0] pc	
);			
	wire [31:0] next_pc;

	always @(posedge reset) pc <= 0;	
	always @(posedge clock) pc <= next_pc;

	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [4:0] rd;
	wire [2:0] funct3;
	wire [6:0] funct7;
	wire [6:0] opcode;

	decoder decoder_instance(
		.inst(inst),
		.rs1(rs1),
		.rs2(rs2),
		.rd(rd),
		.funct3(funct3),
		.funct7(funct7),
		.opcode(opcode)
	);

	wire [31:0] reg_1_data;
	wire [31:0] reg_2_data;
	wire [31:0] reg_write_data;
	wire reg_write;

	reg_file reg_file_instance(
		.clock(clock),
		.write(reg_write),
		.reg_1_sel(rs1),
		.reg_2_sel(rs2),
		.write_reg(rd),
		.write_data(reg_write_data),
		.reg_1_data(reg_1_data),
		.reg_2_data(reg_2_data)
	);

	wire [31:0] imm;

	imm_gen imm_gen_instance(
		.inst(inst),
		.imm(imm)
	);

	wire bus_to_reg;
	wire alu_src_1;
	wire alu_src_2;
	wire out_sel;
	wire branch;
	wire jump;
	wire [1:0] alu_op;

	control control_instance(
		.opcode(opcode),
		.bus_read(bus_read),
		.bus_write(bus_write),
		.bus_to_reg(bus_to_reg),
		.reg_write(reg_write),
		.alu_src_1(alu_src_1),
		.alu_src_2(alu_src_2),
		.out_sel(out_sel),
		.branch(branch),
		.jump(jump),
		.alu_op(alu_op)
	);

	wire [3:0] operation;

	alu_control alu_control_instance(
		.alu_op(alu_op),
		.funct3(funct3),
		.funct7(funct7),
		.operation(operation)
	);

	wire [31:0] operand_1;
	wire [31:0] operand_2;

	mux_2 alu_input_1 (
		.sel(alu_src_1),
		.a(reg_1_data),
		.b(pc),
		.y(operand_1)
	);

	mux_2 alu_input_2 (
		.sel(alu_src_2),
		.a(reg_2_data),
		.b(imm),
		.y(operand_2)
	);

	wire [31:0] alu_result;
	wire zero;

	alu alu_instance(
		.operation(operation),
		.operand_1(operand_1),
		.operand_2(operand_2),
		.result(alu_result),
		.zero(zero)
	);
	
	wire [1:0] pc_source;

	branch_decider branch_decider_instance(
		.branch(branch),
		.jump(jump),
		.funct3(funct3),
		.alu_zero(zero),
		.pc_source(pc_source)
	);

	wire [31:0] default_pc;
	wire [31:0] branch_pc;
	assign default_pc = pc + 4;
	assign branch_pc = pc + imm;

	mux_4 mux_4_instance(
		.sel(pc_source),
		.a(default_pc),
		.b(branch_pc),
		.c(alu_result),
		.d(default_pc),
		.y(next_pc)
	);

	wire [31:0] result;

	mux_2 output_select (
		.sel(out_sel),
		.a(alu_result),
		.b(imm),
		.y(result)
	);

	mux_2 write_back_src(
		.sel(bus_to_reg),
		.a(bus_read_data),
		.b(result),
		.y(reg_write_data)
	);	

	assign bus_write_data = reg_2_data;
	assign bus_address = alu_result;
	
endmodule
