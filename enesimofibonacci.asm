.data

msg1: .asciiz "Digite o N-ésimo da sequÊncia de Fibonacci você gostaria de saber?  "
msg2: .asciiz "O enésimo termo da sequência de Fibonacci é: "

.text

# Imprimir pergunta sobre n-ésimo termo
li $v0, 4
la $a0, msg1
syscall

# ler o número 
li $v0, 5
syscall

#Inicializando as variávies

move $t0, $v0 # Colocando o valor N em $t0
move $t1, $zero # Inicializando $t1
move $t2, $zero # Inicializando $t2
addi $t2, $t2, 1 # Colocando o valor 1 em $t2
move $t4, $zero # Inicializando $t4
addi $t4, $t4, 1 # Contador do loop while em $t4 começando em 1

while:
	bge $t4, $t0, saida  # Comparação
	add $t3, $t1, $t2    # Calculando t3
			
	# Atualizando as variáveis
	move $t1, $t2
	move $t2, $t3
	
	# Atualizando o contador 
	addi $t4, $t4, 1
	
	#Jump do loop while
	j while
	
saida:
	# Imprime a mensagem de saída do n-ésimo termo
	li $v0, 4
	la $a0, msg2
	syscall
		
	# imprime o termo N da sequência de Fibonacci
	li $v0, 1
	move $a0, $t1
	syscall
	
	
