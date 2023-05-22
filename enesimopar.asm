.data

msg1: .asciiz "Digite o enésimo número par que você gostaria de saber:  "
msg2: .asciiz "O enésimo termo par é: "

.text

	# Imprimir pergunta sobre enésimo termo par
	li $v0, 4
	la $a0, msg1
	syscall

	# Ler o número 
	li $v0, 5
	syscall

	# Calculando o enésimo par
	move $t0, $v0
	addi $t1, $t1, 2
	mul $t2, $t1, $t0

	# Imprimir mensagem sobre qual é o enésimo termo par
	li $v0, 4
	la $a0, msg2
	syscall		
						
	# Imprimir qual é o enésimo termo par
	li $v0, 1
	move $a0, $t2
	syscall
