
// Sample Instruction Set Architecture Design
// 1) Choose 2 operand data operations - accumulator mode
// 2) Choose Register names indexed as R<integer> valid for [0..NUM_REGISTERS-1]
// 3) (R0) <-> 0 
module decode_instruction(
  instruction,
  reg_dest,     // Overwritten
  reg_source,   // Not overwritten
  immediate,
  opcode,
  decoded)
  'include "param.v";

  input [INSTRUCTION_WIDTH-1:0] instruction ;
  output [REGFILE_ADDR_BITS-1:0] reg_source ;
  output [REGFILE_ADDR_BITS-1:0] reg_dest ;
  output [IMMEDIATE_WIDTH-1:0] immediate ;
  output [WIDTH_OPCODE-1:0] opcode ;
  output [NUM_INSTRUCTIONS-1:0] decoded ;

  //   Ri .... R7  log 7 base 2 = 3
  // Instruction format 1: Data computation 
  // ASSEMBLY: add R1, R2  ; R1 = R1 + R2 ;
  // opcode | reg_dest | reg_source | unused  
  //   5    |    3     |    5          12      // 25 - 13  = 12
  parameter OPCODE_LSB = INSTRUCTION_WIDTH - WIDTH_OPCODE ;
  assign opcode = instruction[INSTRUCTION_WIDTH-1:OPCODE_LSB];
  // assign opcode = instruction[24:19];
  // This gives 25-1 : 24-5 or [24:19]   25 24 23 22 21
 
 
  parameter DEST_LSB = OPCODE_LSB - REGFILE_ADDR_BITS ;
  assign reg_dest = instruction[OPCODE_LSB-1:DEST_LSB] ;
  // assign reg_dest = instruction[19:17] ;
  // This gives 25-5-1 : 25-5-3 or [19:17]   
 
 
  // Add parameter here:
  assign reg_source = instruction[16:14] ;
  // This gives 25-5-3-1 : 25-5-6 or [16:14] 

  assign immediate = instruction[IMMEDIATE_WIDTH-1:0] ;

  // Instruction formats:
  //
  // ASSEMBLY: nop
  // opcode = INSTR_NOP
  // opcode | unused
  //   5    |   20       // 24 - 5  = 19
  //
  // ASSEMBLY: add R1, R2  ; R1 <= R1 + R2 ;
  // opcode = INSTR_ADD
  // opcode | reg_dest | reg_source | unused  
  //   5    |    3     |    5          10      // 25 - 13  = 12

  // Instruction format 2a: Load Register or lr
  // See my assembly scaled displacement form looks like an array
  // ASSEMBLY: lr RDest, RSource[Immediate] : lr R2, R1[0x10] or load ((R1)+0x10) into R2
  // opcode = INSTR_LR
  // opcode | reg_dest | reg_source | unused | immediate   
  //   5    |    3     |    3          3        12     // 23 - 11 - 12 = 2
  //
  // Instruction format 2b: Save Register
  // ASSEMBLY: sr RDest[Immediate], Rsource : sr R1[0x10], R2 or save R2 -> ((R1)+0x10)
  // opcode = INSTR_SR
  // opcode | reg_dest | reg_source | unused | immediate   
  //   5    |    3     |    3          3        12     // 25 - 11 - 12 = 2
    
  // Your other instructions here.
   
  // Program C = -A + B   A @ 0x10 B @ 0x20 C @ 0x30
     lr R1, R0[0x10]
     lr R2, R0[0x20]
     add R2, R1  ; R2 <= -(R1) + (R2)
     sr R0[0x30], R2
 
  // Program machine encoding:
  // lr opcode = 2. lr R1, R0[0x10]
  // opcode | reg_dest | reg_source | unused | immediate   
  //   5    |    3     |    3          3        12     // 26 - 11 - 12 = 3
  // 00010     001        000         000       0000 0001 0000
  // regroup bits:
  // 00  0100     0100      0000       0000 0001 0000
  // hex value:
  // 0x0440010
  //
  // lr opcode = 2. lr R2, R0[0x20]
  // opcode | reg_dest | reg_source | unused | immediate   
  //   5    |    3     |    3          3        12     // 26 - 11 - 12 = 3
  // 00010     010        000         000       0000 0010 0000
  // regroup bits:
  // 00 0100 1000   0000       0000 0010 0000
  // hex value:
  // 0x0480020
  //
  // add opcode = 1. add R2, R1  ; R2 <= (R1) + (R2)
  // opcode | reg_dest | reg_source | unused | unused   
  //   5    |    3     |    3          3        12     // 26 - 11 - 12 = 3
  // 00001     010        001         000       0000 0000 0000
  // regroup bits:
  // 00 0010  1000 1000  0000 0000 0000
  // hex value:
  // 0x0288000
  //
  // sr opcode = 3. sr Rd[immediate], Rsource
  // ASSEMBLY: sr RDest[Immediate], Rsource : sr R0[0x30], R2
  // opcode | reg_dest | reg_source | unused | immediate   
  //   5    |    3     |    3          3        12     // 26 - 11 - 12 = 3
  // 00011     000        010         000       0000 0011 0000
  // regroup bits:
  // 00  0110  0001  0000       0000 0011 0000
  // hex value:
  // 0x0610030
  //
  // Program 1:
  // 0x0440010
  // 0x0480020
  // 0x0288000
  // 0x0610030
  //
  // Program 2:
  // int sum = 0 ;
  // for( i = 0 ; i <= 10 ; i++ ){
  //   sum += i ; 
  // }
  // Assembly code for sum progam here:
  //
  // Machine code sum progam here:
  
    addi $s1, $0, 0; 
    add $s0, $0, $0
    addi $t0, $0, 10
    
    for: beq $s0, $t0, done
    add $s1, $s1, $s1
    addi $s0, $s0, 1
j for
  
endmodule
