//Instruction Memory Length
`define IM_LENGTH 1023 

//31 Register Address
`define REG_31_ADDR     5'b11111

//initial
`define INIT_32 32'b0
`define INIT_5	5'b0
`define INIT_2  2'b0

// PFU Control Signals
`define PFU_OP_LENGTH      3          // Length of PFU 控制信号
`define PFU_OP_DEFAULT     3'b000     // PFU 默认
`define PFU_OP_NEXT        3'b001     // Next instruction: {PC + 4}
`define PFU_OP_JUMP        3'b010     // Next instruction: {PC[31:28], instr_index, 2'b00}
`define PFU_OP_OFFSET_16   3'b011     // Next instruction: {PC + 4 + offset}
`define PFU_OP_OFFSET_26   3'b100
`define PFU_OP_RS          3'b101     // Next instruction: {rs}

// RegDst Control Signals
`define REG_DST_LENGTH  2
`define WRITE_REG_DEFAULT   2'b00
`define WRITE_REG_RD        2'b01
`define WRITE_REG_RT        2'b10
`define WRITE_REG_31	    2'b11

//CONST FOR CONTROL UNIT
`define EXTEND_LENGTH		2
`define DEFAULT_EXTEND      2'b00
`define ZERO_EXTEND         2'b01
`define SIGN_EXTEND         2'b10
`define SHIFT               2'b11

`define ALU_OP_LENGTH		4
`define ALU_OP_DEFAULT      4'b0000
`define ALU_OP_ADD          4'b0001
`define ALU_OP_AND          4'b0010
`define ALU_OP_MOV          4'b0011
`define ALU_OP_NOR          4'b0100
`define ALU_OP_OR           4'b0101
`define ALU_OP_SLL          4'b0110
`define ALU_OP_SRL          4'b0111
`define ALU_OP_SRA          4'b1000
`define ALU_OP_SLT          4'b1001
`define ALU_OP_SLTU         4'b1010
`define ALU_OP_SUB          4'b1011
`define ALU_OP_XOR          4'b1100
`define ALU_OP_CMP0         4'b1101
`define ALU_OP_CMP          4'b1110

//opcode & function code
`define SPECIAL_OPCODE      6'b000000
`define FUNC_ADD            6'b100000
`define FUNC_ADDU           6'b100001
`define FUNC_AND            6'b100100
`define FUNC_JR_JALR        6'b001001
`define FUNC_MOVN           6'b001011
`define FUNC_MOVZ           6'b001010
`define FUNC_NOP_SLL        6'b000000
`define FUNC_NOR            6'b100111
`define FUNC_OR             6'b100101
`define FUNC_SLLV           6'b000100
`define FUNC_SRL            6'b000010
`define FUNC_SRLV           6'b000110
`define FUNC_SRA            6'b000011
`define FUNC_SRAV           6'b000111
`define FUNC_SLT            6'b101010
`define FUNC_SLTU           6'b101011
`define FUNC_SUB            6'b100010
`define FUNC_SUBU           6'b100011
`define FUNC_XOR            6'b100110

`define INSTR_ADDI          6'b001000
`define INSTR_ADDIU         6'b001001
`define INSTR_ANDI          6'b001100
`define INSTR_AUI           6'b001111
`define INSTR_B_BEQ         6'b000100
`define INSTR_BNE           6'b000101
`define INSTR_BLTZ_BGEZ     6'b000001
`define INSTR_BLEZ          6'b000110
`define INSTR_BGTZ          6'b000111
`define INSTR_LUI           6'b001111
`define INSTR_LW            6'b100011
`define INSTR_ORI           6'b001101
`define INSTR_SLTI          6'b001010
`define INSTR_SLTIU         6'b001011
`define INSTR_SW            6'b101011
`define INSTR_XORI          6'b001110
`define INSTR_BC            6'b110010
`define INSTR_J             6'b000010
`define INSTR_JAL           6'b000011

`define WDATA_SRC_LENGTH	2	
`define WDATA_SRC_DEFAULT   2'b00
`define WDATA_SRC_ALU       2'b01
`define WDATA_SRC_DMEM      2'b10
`define WDATA_SRC_PCplus8   2'b11

`define PFU_OP_DEFAULT      3'b000
`define PFU_OP_NEXT         3'b001
`define PFU_OP_JUMP         3'b010
`define PFU_OP_OFFSET_16    3'b011
`define PFU_OP_OFFSET_26    3'b100
`define PFU_OP_RS           3'b101

`define ALUopnd1_LENGTH 	2
`define ALUopnd1_DEFAULT    2'b00
`define ALUopnd1_RS         2'b01
`define ALUopnd1_SA         2'b10

`define ALUopnd2_LENGTH 	2
`define ALUopnd2_DEFAULT    2'b00
`define ALUopnd2_RT         2'b01
`define ALUopnd2_IMM        2'b10

`define BRANCH_OP_DEFAULT      2'b00
`define BRANCH_OP_CMP          2'b01
`define BRANCH_OP_CMP0         2'b10

`define BRANCH_LENGTH		2
`define BRANCH_DEFAULT      2'b00
`define BRANCH_EQUAL        2'b01
`define BRANCH_LT           2'b10
`define BRANCH_GT           2'b11

`define PAUSE_LENGTH		2
`define PAUSE_NO            2'b00
`define PAUSE_RS            2'b01
`define PAUSE_RT            2'b10
`define PAUSE_BOTH          2'b11