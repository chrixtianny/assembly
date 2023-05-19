.data
F1: .float 32.0
F2: .float 9.0
F3: .float 5.0
prompt_c: .asciiz "Indique a temperatura em Celsius: "
mensagem: .asciiz "A temperatura em Fahrenheit é: "

.text
main:
	li $v0, 4
	la $a0, prompt_c
	syscall
	
	li $v0, 6
	syscall
	
	mov.s $f1, $f0
	
	lwc1 $f2, F2	
	mul.s $f3, $f1, $f2
	
	
	lwc1 $f4, F3
	div.s $f5, $f3, $f4
	
	
	lwc1 $f6, F1
	add.s $f7, $f6, $f5
	
	li $v0, 4
	la $a0, mensagem
	syscall
	
	li $v0, 2
	mov.s $f12, $f7
	syscall
	