# Nome do arquivo: programa_arquitetura.asm
# Criado por: Christianny, Ingrid e Rodrigo 
# Programa escrito para converter temperaturas de graus ºC para ºF e 
# Calcular os termos da sequência de Fibonacci
# e calcular o enésimo número par 


.data
	F1: .float 32.0
	F2: .float 5.0
	F3: .float 9.0
	msg1: .asciiz "Indique a temperatura em Fahrenheit: "
	msg2: .asciiz "A temperatura em Celsius é:  "
	msg3: .asciiz "Digite o enésimo da sequência de Fibonacci você gostaria de saber?  "
	msg4: .asciiz "O enésimo termo da sequência de Fibonacci é: "
	msg5: .asciiz "Considerando 2 o primeiro termo par. Digite o enésimo número par que você gostaria de saber: "
	msg6: .asciiz "O enésimo termo par é: "
	menu: .asciiz "\n1 - Fahrenheit -> Celsius \n2 - Fibonnacci\n3 - Enésimo par\n4 - Sair\n"

.text

opcoes:	
	# impressão do menu
	li $v0, 4 # Imprimir uma string
	la $a0, menu
	syscall
	
	# ler número do menu
	li $v0, 5
	syscall 
	
	# mudando o valor de v0 para t0
	move $t0, $v0
			
	# condicionais do menu
	beq $t0, 1, caso1
	beq $t0, 2, caso2
	beq $t0, 3, caso3
	beq $t0, 4, caso4
	
	
caso1:
	main:
	# imprime mensagem da temperatura em Fahrenheit
	li $v0, 4
	la $a0, msg1
	syscall
	
	# le o valor em Fahrenheit
	li $v0, 6
	syscall

	# convertendo o valor de Fahrenheit para Celsius
	lwc1 $f1, F1
	sub.s $f2, $f0, $f1
	
	lwc1 $f3, F2
	mul.s $f4, $f3, $f2
	
	lwc1 $f5, F3
	div.s $f6, $f4, $f5
	
	# imprime mensagem de saída do grau Celsius
	li $v0, 4
	la $a0, msg2
	syscall
	
	# imprime o valor que foi convertido em Celcius
	li $v0, 2
	mov.s $f12, $f6
	syscall

	j opcoes
								
caso2:
	# imprimir pergunta sobre o enésimo termo de Fibonacci
	li $v0, 4
	la $a0, msg3
	syscall

	# ler o número 
	li $v0, 5
	syscall

	# inicializando as variávies

	move $t0, $v0 # Colocando o valor N em $t0
	move $t1, $zero # Inicializando $t1
	move $t2, $zero # Inicializando $t2
	addi $t2, $t2, 1 # Colocando o valor 1 em $t2
	move $t4, $zero # Inicializando $t4
	addi $t4, $t4, 1 # Contador do loop while em $t4 come?ando em 1

	while:
	bge $t4, $t0, saida  # Comparação
	add $t3, $t1, $t2    # Calculando t3
			
	# atualizando as variaveis
	move $t1, $t2
	move $t2, $t3
	
	# atualizando o contador 
	addi $t4, $t4, 1
	
	# jump do loop while
	j while
	
	saida:
	# imprime a mensagem de saída do enésimo termo
	li $v0, 4
	la $a0, msg4
	syscall
		
	# imprime o termo N da sequ?ncia de Fibonacci
	li $v0, 1
	move $a0, $t1
	syscall	

	j opcoes

caso3:
	# imprimir pergunta sobre enésimo termo par
	li $v0, 4
	la $a0, msg5
	syscall

	# ler o número 
	li $v0, 5
	syscall

	# reiniciar a variável $t1 para 0
	move $t1, $zero
	
	# calculando o enésimo par
	move $t0, $v0
	addi $t1, $t1, 2
	mul $t2, $t1, $t0

	# imprimir mensagem sobre qual é o enésimo termo par
	li $v0, 4
	la $a0, msg6 
	syscall		
						
	# imprimir qual é o enésimo termo par
	li $v0, 1
	move $a0, $t2
	syscall
	
	j opcoes	
			
caso4:
	# encerrar o programa
	li $v0, 10
	syscall	
	
