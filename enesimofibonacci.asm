.data

msg1: .asciiz "Digite o N-�simo da sequ�ncia de Fibonacci voc� gostaria de saber?  "
msg2: .asciiz "O en�simo termo da sequ�ncia de Fibonacci �: "

.text

# Imprimir pergunta sobre n-�simo termo
li $v0, 4
la $a0, msg1
syscall

# ler o n�mero 
li $v0, 5
syscall

#Inicializando as vari�vies

move $t0, $v0 # Colocando o valor N em $t0
move $t1, $zero # Inicializando $t1
move $t2, $zero # Inicializando $t2
addi $t2, $t2, 1 # Colocando o valor 1 em $t2
move $t4, $zero # Inicializando $t4
addi $t4, $t4, 1 # Contador do loop while em $t4 come�ando em 1

while:
	bge $t4, $t0, saida  # Compara��o
	add $t3, $t1, $t2    # Calculando t3
			
	# Atualizando as vari�veis
	move $t1, $t2
	move $t2, $t3
	
	# Atualizando o contador 
	addi $t4, $t4, 1
	
	#Jump do loop while
	j while
	
saida:
	# Imprime a mensagem de sa�da do n-�simo termo
	li $v0, 4
	la $a0, msg2
	syscall
		
	# imprime o termo N da sequ�ncia de Fibonacci
	li $v0, 1
	move $a0, $t1
	syscall
	
	
