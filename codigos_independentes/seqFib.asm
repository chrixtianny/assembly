.data

prompt_num: .asciiz "Indique um número para verificar se pertence à sequência de Fibonacci: "
a: .word 0
b: .word 1
mensagem_pertence: .asciiz "Pertence à Sequência"
mensagem_nao_pertence: .asciiz "Não pertence à Sequência"

.text
main:
    # Imprimir a mensagem solicitando um número para verificar
    li $v0, 4
    la $a0, prompt_num
    syscall

    # Ler o número fornecido pelo usuário
    li $v0, 5
    syscall
    move $t5, $v0
    
    # Carregar os primeiros valores da sequência de Fibonacci em registradores
    lw $t1, a
    lw $t2, b
    
loop:
    # Calcular o próximo termo da sequência de Fibonacci
    add $t3, $t1, $t2

    # Comparar o próximo termo com o número fornecido
    beq $t3, $t5, pertence

    # Verificar se o próximo termo é maior que o número fornecido
    slt $t4, $t3, $t5
    beqz $t4, nao_pertence

    # Atualizar os registradores para o próximo cálculo
    move $t1, $t2
    move $t2, $t3
    
    # Saltar de volta para o início do loop
    j loop

pertence:
    # O número fornecido pertence à sequência de Fibonacci
    li $v0, 4
    la $a0, mensagem_pertence
    syscall
    j fim

nao_pertence:
    # O número fornecido não pertence à sequência de Fibonacci
    li $v0, 4
    la $a0, mensagem_nao_pertence
    syscall
    j fim

fim:
    # Encerrar o programa
    li $v0, 10
    syscall
