.data

msg1: .asciiz "Digite o en�simo n�mero par que voc� gostaria de saber:  "
msg2: .asciiz "O en�simo termo par �: "

.text

	# Imprimir pergunta sobre en�simo termo par
	li $v0, 4
	la $a0, msg1
	syscall

	# Ler o n�mero 
	li $v0, 5
	syscall

	# Calculando o en�simo par
	move $t0, $v0
	addi $t1, $t1, 2
	mul $t2, $t1, $t0

	# Imprimir mensagem sobre qual � o en�simo termo par
	li $v0, 4
	la $a0, msg2
	syscall		
						
	# Imprimir qual � o en�simo termo par
	li $v0, 1
	move $a0, $t2
	syscall
