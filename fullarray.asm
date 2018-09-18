.data
symbol: .space 40
array: .space 40
space: .asciiz " "
return: .asciiz "\n"

.text

main:
	li $v0, 5
	syscall
	move $s0, $v0
	
	move $a1, $zero
	jal FullArray
	
	li $v0, 10
	syscall
	
FullArray:
#
	bne $a1, $s0, perm
	move $t9, $zero
	print:
		li $v0, 1
		mul $t8, $t9, 4
		lw $a0, array($t8)
		syscall
		li $v0, 4
		la $a0, space
		syscall
		addi $t9, $t9, 1
		bne $t9, $s0, print
		li $v0, 4
		la $a0, return
		syscall
		jr $ra
#

perm:
#
	move $t0, $a1
	
	move $t1, $zero
	for:
		mul $t9, $t1, 4
		lw $t2, symbol($t9)
		bne $t2, $zero, next
		mul $t8, $t0, 4
		lw $t3, array($t8)
		addi $t3, $t1, 1
		sw $t3, array($t8)
		li $t2, 1
		sw $t2, symbol($t9)
		
		sw $ra, 0($sp)
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		addi $sp, $sp, -4
		sw $a1, 0($sp)
		addi $sp, $sp, -4
		
		addi $a1, $a1, 1
		jal FullArray
		
		addi $sp, $sp, 4
		lw $a1, 0($sp)
		addi $sp, $sp, 4
		lw $t1, 0($sp)
		addi $sp, $sp, 4
		lw $t0, 0($sp)
		addi $sp, $sp, 4
		lw $ra, 0($sp)
		
		mul $t9, $t1, 4
		li $t2, 0
		sw $t2, symbol($t9)
		bne $t1, $s0, next
		jr $ra
	next:
		addi $t1, $t1, 1
		bne $t1, $s0, for
		jr $ra
#
