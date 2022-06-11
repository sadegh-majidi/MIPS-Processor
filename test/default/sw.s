li $1, 0xfafbfcfd
li $2, 0x01020304
li $3, 0xa0b0c0d0
addi $7, $0, 12
sw $1, 8($7)
sw $2, 8($0)
sw $3, 0($7)
lb $8, 8($0)
addi $7, $0, 12
syscall
