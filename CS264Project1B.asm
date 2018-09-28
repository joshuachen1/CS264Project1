# Who:	Joshua Chen
# What:	CS264Project1B.asm
# Why:	Part B of Project 1 to read an array of 20 integers with an appropriate prompt, store it, and then prints all integers in a single line separated by spaces.
# When:	Created: 4/21/18	Due: 4/25/18
# How:	
#	$t0 is used to keep track of the index.
#	$t1 is used to temporarily load the word of an array at the current index.
#	$v0 is used to load service numbers for system calls.
#	$a0 is used to load argument values for system calls.

.data
array:		.space		80
arraySize:	.word		20
procedureText:  .asciiz		"Procedure B: ALL INTEGERS IN A SINGLE LINE SEPERATED BY SPACES"
nextInt:	.asciiz		"Enter an integer: "
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

addi	$t0, $zero, 0			# Clear $t0 to 0

li	$v0, 4				# $v0 = Print String
la	$a0, newLine		
syscall
la	$a0, procedureText		
syscall	
la	$a0, newLine		
syscall
procedureB:
	beq 	$t0, 80, exit2		# If the value at $t0 is 80 (20 words)
	
	lw 	$t1, array($t0)		# Load word at the current index into $t1
	li	$v0, 1			# $v0 = print integer
	move	$a0, $t1		# $a0 = value at $t1
	syscall				# Print integer
	
	li	$v0, 4			# $v0 = Print String
	la	$a0, addspace		# Spaces between each value
	syscall
	
	add	$t0, $t0, 4		# Move $t0 4 bits
	j	procedureB
exit2:

li 	$v0, 10				# terminate the program
syscall