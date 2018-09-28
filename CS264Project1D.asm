# Who:	Joshua Chen
# What:	CS264Project1.asm
# Why:	A templete to be used for all CS264 Labs
# When:	Created: 4/21/18	Due: 4/25/18
# How:	
#	$t0 is used to track of the index.
#	$t1 stores the value of n; and keeps track of (n*4) bits
#	$t2 is used to check if n <= 20; and if (n <= 20) && (n < 0); and keeps track of the number of values printed per line
#	$t3 is ised to check if n > 0; and is used to temporarily load the word of an array at the current index.

.data
array:		.space		80
arraySize:	.word		20
nextInt:	.asciiz		"Enter an integer: "
invalidN:	.asciiz		"Invalid value for n.\n"
promptN:	.asciiz		"Enter a value for n (Between 1 and 20): "
addspace:	.asciiz		" "
newLine:	.asciiz		"\n"

.text 
.globl main
main: 					# program entry
addi	$t0, $zero, 0			# Clear $t0 to 0

initializeArray: 	
	beq	$t0, 80, exit1		# If the value at $t0 is 80 (20 words)
	
	li	$v0, 4			# $v0 = Print String
	la	$a0, nextInt		
	syscall	
	
	li	$v0, 5			# $v0 = Read Integer
	syscall
	
	sw	$v0, array($t0)
	add	$t0, $t0, 4		# Move $t0 4 bits
	j	initializeArray
exit1:

initializeN:
	li	$v0, 4
	la	$a0, promptN
	syscall
	li	$v0, 5
	syscall
	move	$t1, $v0		# Store n in $t1
	
	beq 	$t1, 20, exit2		# If n == 20
	
	slti	$t2, $t1, 20		# $t2 =  n < 20
	slt	$t3, $zero, $t1		# $t3 =  0 < n
	and	$t2, $t2, $t3		# $t2 = (n < 20) && (0 < n)
	beq	$t2, 1, exit2		# if $t2 == 1
	
	li	$v0, 4
	la	$a0, invalidN
	syscall
	j	initializeN
	
exit2:

add 	$t0, $zero, 0			# Clear $t0 to 0
add	$t2, $zero, 0			# Clear $t2 to 0

sll	$t1, $t1, 2			# Multiply n by 4

printLineProcedure:
	beq	$t2, $t1, nextLineProcedure	# If ($t2 == $t1), move to nextLineProcedure to move to the next line
	
	lw 	$t3, array($t0)		# Load word at the current index into $t3
	li	$v0, 1			# $v0 = print integer
	move	$a0, $t3		# $a0 = value at $t1
	syscall				# Print integer
	
	li	$v0, 4			# $v0 = Print String
	la	$a0, addspace		# Spaces between each value
	syscall
	
	add	$t0, $t0, 4		# Move $t0 4 bits
	add	$t2, $t2, 4		# Move $t2 4 bits
	
	beq	$t0, 80, exit3
	
	j	printLineProcedure
	
	
exit3:

li 	$v0, 10				# terminate the program
syscall

nextLineProcedure:
	add	$t2, $zero, 0		# Clear $t2 to 0 for future lines
	
	li	$v0, 4			# $v0 = Print String
	la	$a0, newLine			
	syscall				# Goes to next line
	
	j	printLineProcedure	# Jump to printLineProcedure to continue printing

