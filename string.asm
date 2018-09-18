.data
string: .space 100

.text
main:
	li $v0, 5
	syscall
	move $s0, $v0
	
	move $t0, $zero
	la $t1, string
	jal write
	
	move $t0, $zero
	move $t1, $zero
	addi $s1, $s0, -1 
	move $t2, $s1
	move $t3, $zero
	jal cmp
	
	li $v0, 1
	li $a0, 1
	syscall
	
	li $v0, 10
	syscall

write:
#
	li $v0, 12
	syscall
	sw $v0, 0($t1)
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	bne $t0, $s0, write
	jr $ra
#

cmp:
#
	beq $t0, $t2, al
	slt $t9, $t2, $t0
	beq $t9, 1, al
	
	mul $t9, $t0, 4
	lw $t1, string($t9)
	mul $t9, $t2, 4
	lw $t3, string($t9)
	bne $t1, $t3, ne
	addi $t0, $t0, 1
	addi $t2, $t2, -1
	j cmp
	jr $ra
#	

al:
	jr $ra

ne:
	li $v0, 1
	li $a0, 0
	syscall
	li $v0, 10
	syscall