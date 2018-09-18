.data
martix1: .space 400
martix2: .space 400
space: .asciiz " "
return: .asciiz "\n"

.text
#
li $v0, 5
syscall
move $s0, $v0
mul $s1, $s0, $s0

la $t0, martix1
move $t1, $zero
jal write

la $t0, martix2
move $t1, $zero
jal write

move $s1, $zero
move $s2, $zero
move $s3, $zero
jal multi

jal exit
#

write:
#
li $v0, 5
syscall
sw $v0, 0($t0)
addi $t0, $t0, 4
addi $t1, $t1, 1
bne $s1, $t1, write
jr $ra
#

multi:
#
mul $t4, $s0, $s1
add $t4, $s3, $t4
sll $t4, $t4, 2
lw $t1, martix1($t4)
mul $t4, $s3, $s0
add $t4, $t4, $s2
sll $t4, $t4, 2
lw $t2, martix2($t4)
mul $t3, $t2, $t1
add $a0, $a0, $t3
addi $s3, $s3, 1
bne $s3, $s0, multi
#next column
li $v0, 1
syscall
li $v0, 4
la $a0, space
syscall
move $a0, $zero
addi $s2, $s2, 1
move $s3, $zero
bne $s2, $s0, multi
li $v0, 4
la $a0, return
syscall
#next line
addi $s1, $s1, 1
move $s2, $zero
move $s3, $zero
move $a0, $zero
bne $s1, $s0, multi

jr $ra
#

exit:
nop