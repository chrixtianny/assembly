.data
prompt_num: .asciiz "Indique um número para verificar se pertence à sequência de Fibonacci: "
a: .word 0
b: .word 1
mensagem_pertence: .asciiz "Pertence à Sequência"
mensagem_nao_pertence: .asciiz "Não pertence à Sequência"

.text
main:
li $v0, 4
la $a0, prompt_num
syscall

li $v0, 5
syscall
move $t5, $v0
    
lw $t1, a
lw $t2, b
    
loop:
add $t3, $t1, $t2

# add $t6, $t5, $t3 Proximo valor

beq $t3, $t5, pertence
slt $t4, $t3, $t5
beqz $t4, nao_pertence

move $t1, $t2
move $t2, $t3
    
j loop

pertence:
li $v0, 4
la $a0, mensagem_pertence
syscall
j fim
nao_pertence:
li $v0, 4
la $a0, mensagem_nao_pertence
syscall
j fim

fim:
li $v0, 10
syscall