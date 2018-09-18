addi $1, $0, 1
ori $2, $2, 1

li $20, 150
li $21, 50
sw $20, 0($31)
sw $21, 4($31)

lw $10, 0($31)
lw $11, 4($31)
#RAM[3:0] stores 150
#RAM[7:4] stores 50
sub $10, $10, $11
addi $10, $10, 50
addi $10, $10, -50
loop:
addi $9, $9, 4
add $3, $1, $2
move $1, $2
nop
move $2, $3
sw $2, 0($9)
nop
beq $10, $9, next
j loop

next:
	lui $1, 0xffff
	sw $1, 0($0)