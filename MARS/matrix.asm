.data
row: .space 3200 #row
column: .space 3200 #column
value: .space 3200 #value
space: .asciiz " "
return: .asciiz "\n"

.text
#init
move $t0, $zero # $t0: the element to read
li $t1, 1 # $t1: a
li $t2, 1 # $t2: b
move $t3, $zero # $t3: the number of non_zero elements
move $s0, $zero # $s0: n, rows
move $s1, $zero # $s1: m, columns
la $s2, row # $s2: the address of row
la $s3, column # $s3: the address of column
la $s4, value # $s4: the address of value
la $s5, space # $s5: the address of space
la $s6, return # $s6: the address of return
move $t5, $zero

# read the number of rows and columns
li $v0, 5
syscall
move $s0, $v0 # $s0: n, rows
li $v0, 5
syscall
move $s1, $v0 # $s1: m, columns

# bulid the matrix
## while( a <= n )
build_a:
	slt $t4, $s0, $t1
	beq $t4, 1, print
	## b = 1
	li $t2, 1
	## while( b <= m )
	build_b:
		slt $t4, $s1, $t2
		beq $t4, 1, build_a_left
			### scanf("%d", &t);
			li $v0, 5
			syscall
			move $t0, $v0
			### if (t != 0)
			beq $t0, $zero, t_zero
				#### write a into row;
        #### write b into column;
        #### write t into value;
        #### the address of row, column, value += 4;
        sw $t1, 0($s2)
        sw $t2, 0($s3)
        sw $t0, 0($s4)
        addi $t5, $t5, 1
        addi $s2, $s2, 4
        addi $s3, $s3, 4
        addi $s4, $s4, 4
		t_zero:
		addi $t2, $t2, 1
			jal build_b 
	build_a_left:
		addi $t1, $t1, 1
		jal build_a
print:
# while(num > 0)
	slt $t4, $zero, $t5
	bne $t4, 1, end
	# printf("row column value\n");
	addi $s2, $s2, -4
	addi $s3, $s3, -4
	addi $s4, $s4, -4
	li $v0, 1
	lw $a0, 0($s2)
	syscall
	
	li $v0, 4
	move $a0, $s5
	syscall
	
	li $v0, 1
	lw $a0, 0($s3)
	syscall
	
	li $v0, 4
	move $a0, $s5
	syscall
	
	li $v0, 1
	lw $a0, 0($s4)
	syscall
	
	li $v0, 4
	move $a0, $s6
	syscall
	
  # num--;
  addi $t5, $t5, -1
  jal print
	
end:
	nop
	

	
		
	
		
		
		
		
		
		
		
		
		
		
