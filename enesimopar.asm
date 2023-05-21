.data

msg1: .asciiz "Digite o N-ésimo número par que você gostaria de saber:  "
msg2: .asciiz "O enésimo termo par é: "

.text

# Imprimir pergunta sobre n-ésimo termo par
li $v0, 4
la $a0, msg1
syscall

# ler o número 
li $v0, 5
syscall

#Calculando o enésimo par
move $t0, $v0
subi $t0,$t0,1
move $t1, $zero
addi $t1, $t1, 2
mul $t2, $t1, $t0

# Imprimir pergunta sobre n-ésimo termo par
li $v0, 4
la $a0, msg2
syscall		
						
# imprime o termo N da sequência de Fibonacci
li $v0, 1
move $a0, $t2
syscall
