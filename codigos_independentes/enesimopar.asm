.data

msg1: .asciiz "Digite o enésimo número par que você gostaria de saber:  "
msg2: .asciiz "O enésimo termo par é: "

.text

	# Imprimir pergunta sobre enésimo termo par
	li $v0, 4           # Carrega o valor 4 em $v0 para realizar a chamada do sistema para imprimir uma string
	la $a0, msg1        # Carrega o endereço da mensagem msg1 em $a0 para ser impressa
	syscall             # Realiza a chamada do sistema para imprimir a mensagem

	# Ler o número 
	li $v0, 5           # Carrega o valor 5 em $v0 para realizar a chamada do sistema para ler um inteiro
	syscall             # Realiza a chamada do sistema para ler o número digitado pelo usuário e armazenar em $v0

	# Calculando o enésimo par
	move $t0, $v0       # Move o valor digitado para $t0 para ser usado no cálculo
	addi $t1, $t1, 2    # Adiciona 2 a $t1 para obter o primeiro número par (2)
	mul $t2, $t1, $t0   # Multiplica $t1 (2) pelo valor digitado ($t0) para obter o enésimo termo par

	# Imprimir mensagem sobre qual é o enésimo termo par
	li $v0, 4           # Carrega o valor 4 em $v0 para realizar a chamada do sistema para imprimir uma string
	la $a0, msg2        # Carrega o endereço da mensagem msg2 em $a0 para ser impressa
	syscall             # Realiza a chamada do sistema para imprimir a mensagem

	# Imprimir qual é o enésimo termo par
	li $v0, 1           # Carrega o valor 1 em $v0 para realizar a chamada do sistema para imprimir um inteiro
	move $a0, $t2       # Move o valor do enésimo termo par ($t2) para $a0 para ser impresso
	syscall             # Realiza a chamada do sistema para imprimir o enésimo termo par