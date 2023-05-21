# Nome do arquivo: programa_arquitetura.asm
# Criado por: Christiane, Ingrid e Rodrigo 
# Programa escrito para converter temperaturas de graus ºC para ºF e 
# calcula os termos da sequência de Fibonacci
# e calcular o enésimo número par

.data
F1: .float 32.0
F2: .float 5.0
F3: .float 9.0
prompt_f: .asciiz "Indique a temperatura em Fahrenheit: "
mensagem: .asciiz "A temperatura em Celsius é:  "
msg1: .asciiz "Digite o N-ésimo da sequência de Fibonacci você gostaria de saber?  "
msg2: .asciiz "O enésimo termo da sequÊncia de Fibonacci é: "
msg3: .asciiz "Digite o N-ésimo número par que você gostaria de saber:  "
msg4: .asciiz "O enésimo termo par é: "
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
			
# Condicionais do menu

beq $t0, 1, caso1
beq $t0, 2, caso2
beq $t0, 3, caso3
beq $t0, 4, caso4
	
caso1:
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

j opcoes
								
caso2:
# Imprimir pergunta sobre n-?simo termo
li $v0, 4
la $a0, msg1
syscall

# ler o n?mero 
li $v0, 5
syscall

#Inicializando as vari?vies

move $t0, $v0 # Colocando o valor N em $t0
move $t1, $zero # Inicializando $t1
move $t2, $zero # Inicializando $t2
addi $t2, $t2, 1 # Colocando o valor 1 em $t2
move $t4, $zero # Inicializando $t4
addi $t4, $t4, 1 # Contador do loop while em $t4 come?ando em 1

while:
bge $t4, $t0, saida  # Comparação
add $t3, $t1, $t2    # Calculando t3
			
# Atualizando as vari?veis
move $t1, $t2
move $t2, $t3
	
# Atualizando o contador 
addi $t4, $t4, 1
	
#Jump do loop while
j while
	
saida:
# Imprime a mensagem de sa?da do n-?simo termo
li $v0, 4
la $a0, msg2
syscall
		
# imprime o termo N da sequ?ncia de Fibonacci
li $v0, 1
move $a0, $t1
syscall	

j opcoes

caso3:
	
# Imprimir pergunta sobre n-?simo termo par
li $v0, 4
la $a0, msg3
syscall

# ler o n?mero 
li $v0, 5
syscall

#Calculando o en?simo par
move $t0, $v0
subi $t0,$t0,1
move $t1, $zero
addi $t1, $t1, 2
mul $t2, $t1, $t0

# Imprimir pergunta sobre n-?simo termo par
li $v0, 4
la $a0, msg4
syscall		
						
# imprime o termo N da sequ?ncia de Fibonacci
li $v0, 1
move $a0, $t2
syscall

j opcoes	
			
caso4:

# encerrar o programa
li $v0, 10
syscall	
	

