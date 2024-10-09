//Smriti Rai
//CE4304.002

parameter ADDRESS_BUS_WIDTH = 10 ;
parameter NUM_ADDRESS = 16384 ;
parameter PROGRAM_LOAD_ADRESS = 512 ;
parameter DATA_BUS_WIDTH = 48 ;
parameter REGFILE_ADDR_BITS = 3 ;
parameter NUM_REGISTERS = 8 ;
parameter WIDTH_REGISTER_FILE = 48 ;
parameter INSTRUCTION_WIDTH = 25 ;
parameter IMMEDIATE_WIDTH = 12 ;
parameter NUM_INSTRUCTIONS = 16 ;
parameter WIDTH_OPCODE = 5 ; 

// Decoded instructions: 
parameter INSTR_NOP = 0; 
parameter INSTR_ADD = 1;
parameter INSTR_LR = 2; 
parameter INSTR_SR = 3; 
parameter INSTR_BNEQ = 4;
parameter INSTR_MOV = 5; 
parameter INSTR_LI = 6; 
parameter INSTR_ADDI = 7;

parameter OP_ADD = 0; 
parameter OP_SUB = 1;
parameter OP_AND = 2;
parameter OP_OR = 3;
parameter OP_EQUAL = 4;
parameter OP_DIVIDE = 5; 

parameter STATE_BITS = 4; 
parameter NUM_STATES = (1 << STATE_BITS);

parameter STATE_FETCH = 0 ;
parameter STATE_DECODE = 1 ;
parameter STATE_EXEC = 2 ;


parameter INSTR_ = 15 ;
//    register file index 4 it takes 3 bits to encode r0...r7
///   addr  --------------------
//          | 48            14 |
//       r0 |  .............   |      
//       r1 |  width of data   |      
//          |                  |
//       .  |                  |
//       .  |                  |
//       .  |                  |
//          |                  |
//       r7 |                  |
//          |                  |
///         --------------------
//