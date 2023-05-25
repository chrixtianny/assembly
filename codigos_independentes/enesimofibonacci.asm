.data
msg1: .asciiz "Digite o enésimo da sequência de Fibonacci você gostaria de saber?  "
msg2: .asciiz "O enésimo termo da sequência de Fibonacci é: "

.text

# Imprimir pergunta sobre o enésimo termo
li $v0, 4        # Carrega o valor 4 no registrador $v0 (código do syscall para imprimir string)
la $a0, msg1    # Carrega o endereço da mensagem msg1 no registrador $a0 (argumento para syscall)
syscall         # Executa a syscall para imprimir a mensagem

# Ler o número
li $v0, 5    # Carrega o valor 5 no registrador $v0 (código do syscall para ler inteiro)
syscall     # Executa a syscall para ler o número digitado pelo usuário
            # O valor digitado será armazenado no registrador $v0

# Inicializando as váriáveis
move $t0, $v0    # Move o valor digitado para o registrador $t0 (armazenará o valor N)
move $t1, $zero  # Inicializa $t1 com zero (armazenará o valor atual da sequência)
move $t2, $zero  # Inicializa $t2 com zero (armazenará o valor anterior da sequência)
addi $t2, $t2, 1 # Adiciona 1 a $t2 (inicializando o segundo termo da sequência como 1)
move $t4, $zero  # Inicializa $t4 com zero (contador do loop while)
addi $t4, $t4, 1 # Adiciona 1 a $t4 (inicia o contador do loop while em 1)

while:
    bge $t4, $t0, saida  # Compara $t4 com $t0 (verifica se o contador alcançou o valor N)
                        # Se $t4 >= $t0, o programa sai do loop
    add $t3, $t1, $t2    # Soma $t1 e $t2 e armazena o resultado em $t3 (próximo termo da sequência)

    # Atualizando as váriáveis
    move $t1, $t2    # Move o valor de $t2 para $t1 (atualiza o valor atual da sequência)
    move $t2, $t3    # Move o valor de $t3 para $t2 (atualiza o valor anterior da sequência)

    # Atualizando o contador
    addi $t4, $t4, 1 # Adiciona 1 ao contador $t4

    # Salto para o início do loop while
    j while

saida:
    # Imprime a mensagem de saída do enésimo termo
    li $v0, 4       # Carrega o valor 4 no registrador $v0 (código do syscall para imprimir string)
    la $a0, msg2    # Carrega o endereço da mensagem msg2 no registrador $a0 (argumento para syscall)
    syscall         # Executa a syscall para imprimir a mensagem

    # Imprime o termo N da sequência de Fibonacci
    li $v0, 1       # Carrega o valor 1


	
