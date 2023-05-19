.data
F1: .float 32.0
F2: .float 5.0
F3: .float 9.0
prompt_f: .asciiz "Indique a temperatura em Fahrenheit: "
mensagem: .asciiz "A temperatura em Celsius é: "

.text
main:
	li $v0, 4
	la $a0, prompt_f
	syscall
	
	li $v0, 6
	syscall
	
	lwc1 $f1, F1
	sub.s $f2, $f0, $f1
	
	lwc1 $f3, F2
	mul.s $f4, $f3, $f2
	
	lwc1 $f5, F3
	div.s $f6, $f4, $f5
	
	li $v0, 4
	la $a0, mensagem
	syscall
	
	li $v0, 2
	mov.s $f12, $f6
	syscall
	