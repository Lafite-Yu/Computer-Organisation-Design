#int main()
#{
#	int n = 0;
move $s1, $zero
#	int judge = 0;
move $s2, $zero
#	scanf("%d", &n);
li $v0, 5
syscall
move $s1, $v0
#	if( n % 4 == 0)
if:
	li $t0, 4
	div $s1, $t0
	mfhi $t1
	bne $t1, $zero, end
#		if ( n % 100 == 0)
		li $t0, 100
		div $s1, $t0
		mfhi $t2
		bne $t2, $zero, if_2_else
#			if ( n % 400 == 0)
			li $t0, 400
			div $s1, $t0
			mfhi $t3
			bne $t3, $zero, if_3_else
#				judge = 1;
				li $s2, 1
				jal end
				
#			else
if_3_else:
#			    judge = 0;
	jal end
	
#		else
if_2_else:
#			judge = 1;
	li $s2, 1
	jal end
	
end:
	move $a0, $s2
	li $v0, 1
	syscall
	nop
#	printf("%d\n", judge);
#	return 0;
#}
