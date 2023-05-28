// Opcodes
`define OPCODE_LOAD     7'b0000011
`define OPCODE_OP_IMM   7'b0010011
`define OPCODE_AUIPC    7'b0010111
`define OPCODE_STORE    7'b0100011
`define OPCODE_OP       7'b0110011
`define OPCODE_LUI      7'b0110111
`define OPCODE_BRANCH   7'b1100011
`define OPCODE_JALR     7'b1100111
`define OPCODE_JAL      7'b1101111

// ALU operations
`define ALU_NOP     4'b0000
`define ALU_ADD     4'b0001
`define ALU_SUB     4'b0010
`define ALU_SLL     4'b0011
`define ALU_SRL     4'b0100
`define ALU_SRA     4'b0101
`define ALU_EQ      4'b0110
`define ALU_LT      4'b0111
`define ALU_LTU     4'b1000
`define ALU_XOR     4'b1001
`define ALU_OR      4'b1010
`define ALU_AND     4'b1011

// ALU operation types
`define CTL_ALU_ADD    2'b00
`define CTL_ALU_BRANCH 2'b01
`define CTL_ALU_OP     2'b10
`define CTL_ALU_OP_IMM 2'b11

// ALU 1st operand source
`define CTL_ALU_1_RS1   1'b0
`define CTL_ALU_1_PC    1'b1

// ALU 2nd operand source
`define CTL_ALU_2_RS2   1'b0
`define CTL_ALU_2_IMM   1'b1

// Output select
`define CTL_ALU   1'b0
`define CTL_IMM   1'b1

// Branch address source
`define CTL_IMM_PC   1'b0
`define CTL_IMM   1'b1