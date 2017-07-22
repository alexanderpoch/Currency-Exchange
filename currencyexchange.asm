.data
#The following prompt the user to input
prompt:	.asciiz "Enter a Currency Code: "
prompt2: .asciiz "Enter the USD Amount: $"
endl:	.asciiz "\n"
#The following are the double values of the conversion rates 
brit: .double .80086
india: .double 65.5345
eu:	.double	.92487
aus:	.double	1.29909
can:	.double	1.33492
#These are the outputs
output:	.asciiz	"Conversion is: "
bp:	.asciiz " pounds\n"
ir:	.asciiz " rupees\n"
eur:	.asciiz " euros\n"
ad:	.asciiz " Austrailian D.\n"
cd:	.asciiz	"Canadian D.\n"
.text
main:
	li	$v0,4
	la	$a0, prompt
	syscall	# prompts user to enter currency code
	li	$v0, 5
	syscall	#user enters currency code (int)
	move $v1, $v0
	
	li	$v0,4
	la	$a0,endl
	syscall	#indent
	
	li	$v0,4
	la	$a0,prompt2
	syscall	#asks user to enter the dollar amount
	
	li	$v0, 7 #user inputs dollar amount (double)
	syscall
	mov.d $f2,$f0	# the double value is moved from $f0 to $f2
	
	
	#the following check if the currency code is equal to a given  int. If it is the program jumps to its respective location
	beq	$v1, 1, pound
	beq	$v1, 2, rupee
	beq	$v1, 3, euro
	beq	$v1, 4, aussie
	beq	$v1, 5, canada
	ble	$v1, 0, end
	bge	$v1, 6, end
pound:
	l.d	$f4, brit	#loads the exchange rate into the register
	mul.d	$f6, $f4, $f2	#multiplies exchange rate by dollar amount, stores it in $f6
	mov.d	$f12, $f6	#moves the result to $f12 for output
	
	li	$v0,4
	la	$a0,output
	syscall	# conversion is:
	
	li	$v0, 3
	syscall # outputs double result
	
	li	$v0,4
	la	$a0,bp
	syscall	#writes what currency is has exchanged to
	
	j	end #jumps to end of program
rupee:
	l.d	$f4, india #loads the exchange rate into the register
	mul.d	$f6, $f4, $f2	#multiplies exchange rate by dollar amount, stores it in $f6
	mov.d	$f12, $f6	#moves the result to $f12 for output
	
	li	$v0,4
	la	$a0,output
	syscall
	
	li	$v0, 3
	syscall	# outputs double result
	
	li	$v0,4
	la	$a0,ir
	syscall	#writes what currency is has exchanged to
	
	j	end
euro:
l.d	$f4, eu	#loads the exchange rate into the register
	mul.d	$f6, $f4, $f2	#multiplies exchange rate by dollar amount, stores it in $f6
	mov.d	$f12, $f6	#moves the result to $f12 for output
	
	li	$v0,4
	la	$a0,output
	syscall
	
	li	$v0, 3
	syscall	# outputs double result
	
	li	$v0,4
	la	$a0,eur
	syscall	#writes what currency is has exchanged to
	
	j	end
aussie:
l.d	$f4, aus	#loads the exchange rate into the register
	mul.d	$f6, $f4, $f2	#multiplies exchange rate by dollar amount, stores it in $f6
	mov.d	$f12, $f6	#moves the result to $f12 for output
	
	li	$v0,4
	la	$a0,output
	syscall
	
	li	$v0, 3
	syscall	# outputs double result
	
	li	$v0,4
	la	$a0,ad
	syscall	#writes what currency is has exchanged to
	
	j	end
canada:
l.d	$f4, can	#loads the exchange rate into the register
	mul.d	$f6, $f4, $f2	#multiplies exchange rate by dollar amount, stores it in $f6
	mov.d	$f12, $f6	#moves the result to $f12 for output
	
	li	$v0,4
	la	$a0,output
	syscall
	
	li	$v0, 3
	syscall	# outputs double result
	
	li	$v0,4
	la	$a0,cd
	syscall	#writes what currency is has exchanged to
	
	j	end
end:
	li	$v0, 10	#ends program
	syscall
