.data
num: .space 500
space: .asciiz " "


.text
li $v0, 5
syscall
move $s0, $v0

move $t0, $zero
la $s1, num
jal write

move $t0, $zero
move $t1, $zero
la $t2, num
li $t3, 100000
la $t4, num
jal sort

move $t0, $zero
jal print

li $v0, 10
syscall


write:
#
li $v0, 5
syscall
sw $v0, 0($s1)
addi $t0, $t0, 1
addi $s1, $s1, 4
bne $t0, $s0, write
jr $ra
#

sort:
#
move $t2, $t0
sort1:
mul $t9, $t2, 4
lw $t1, num($t9)
slt $a0, $t1, $t3
beq $a0, 1, exchange1
sort2:
addi $t2, $t2, 1
bne $t2, $s0, sort1
mul $t4, $t4, 4
j exchange2
sort3:
addi $t0, $t0, 1
move $t1, $zero
li $t3, 100000
la $t4, num
bne $t0, $s0, sort
jr $ra
#

exchange1:
#
move $t3, $t1
move $t4, $t2
j sort2
#

exchange2:
#
mul $t8, $t0, 4
lw $t9, num($t8)
sw $t3, num($t8)
sw $t9, num($t4)
j sort3
#

print:
#
li $v0, 1
mul $t9, $t0, 4
lw $a0, num($t9)
addi $t0, $t0, 1
syscall
li $v0, 4
la $a0, space
syscall
bne $t0, $s0, print
jr $ra
#