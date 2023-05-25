################################################################################
# Nome do Projeto: Conversor de Temperaturas e Sequência de Fibonacci em MIPS
#
# Autor(es): Christianny, Ingrid e Rodrigo
# Disciplina: Arquitetura e Organização de Computadores
# Instituição: Instituto Federal de Alagoas - IFAL
# Professor: Ivo Augusto Andrade Rocha Calado
#
# Descrição:
# Este programa em Assembly MIPS realiza a conversão de temperaturas de graus Celsius (ºC) para Fahrenheit (ºF),
# calcula os termos da sequência de Fibonacci e determina o enésimo número par, com base em uma entrada fornecida pelo usuário.
# O programa foi desenvolvido como parte do trabalho da disciplina de Arquitetura e Organização de Computadores do curso de Sistemas de Informações.
# O objetivo é demonstrar o conhecimento em linguagem Assembly MIPS e sua aplicação para realizar operações matemáticas simples.
#
# Arquivo: projeto_assembly_mips.asm
################################################################################


.data
    # Constantes utilizadas na conversão de Fahrenheit para Celsius
    F1: .float 32.0     
    F2: .float 5.0        
    F3: .float 9.0  
    # String a ser exibida no Run I/O do Mars
    msg1: .asciiz "Indique a temperatura em Fahrenheit: " 
    msg2: .asciiz "A temperatura em Celsius é: "   
    msg3: .asciiz "Digite o enésimo termo da sequência de Fibonacci que você gostaria de saber: "
    msg4: .asciiz "O enésimo termo da sequência de Fibonacci é: " 
    msg5: .asciiz "Considerando 2 como o primeiro termo par. Digite o enésimo número par que você gostaria de saber: "
    msg6: .asciiz "O enésimo termo par é: "     
    menu: .asciiz "\n1 - Fahrenheit -> Celsius \n2 - Fibonacci\n3 - Enésimo termo par\n4 - Sair\n"   
.text
opcoes:
    # Impressão do menu
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string (código do syscall para imprimir string)
    la $a0, menu        # Carrega o endereço da string do menu em $a0 (argumento para syscall)
    syscall             # Realiza a chamada do sistema para imprimir o menu

    # Ler número do menu
    li $v0, 5           # Carrega o valor 5 em $v0 para ler um inteiro (código do syscall para ler um inteiro)
    syscall             # Realiza a chamada do sistema para ler o número

    # Mudando o valor de $v0 para $t0
    move $t0, $v0       # Move o valor lido para $t0

    # Condicionais do menu
    beq $t0, 1, caso1   # Se $t0 for igual a 1, salta para o caso1
    beq $t0, 2, caso2   # Se $t0 for igual a 2, salta para o caso2
    beq $t0, 3, caso3   # Se $t0 for igual a 3, salta para o caso3
    beq $t0, 4, caso4   # Se $t0 for igual a 4, salta para o caso4

caso1:
    # Conversão de Fahrenheit para Celsius
    # Imprime mensagem da temperatura em Fahrenheit
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg1        # Carrega o endereço da mensagem em $a0 (argumento para syscall)
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Lê o valor em Fahrenheit
    li $v0, 6           # Carrega o valor 6 em $v0 para ler um número de ponto flutuante
    syscall             # Realiza a chamada do sistema para ler o valor

    # Conversão do valor de Fahrenheit para Celsius
    lwc1 $f1, F1        # Carrega o valor da constante F1 em $f1
    sub.s $f2, $f0, $f1 # Subtrai o valor lido de Fahrenheit pela constante F1 e armazena em $f2

    lwc1 $f3, F2        # Carrega o valor da constante F2 em $f3
    mul.s $f4, $f3, $f2 # Multiplica o valor de $f2 pela constante F2 e armazena em $f4

    lwc1 $f5, F3        # Carrega o valor da constante F3 em $f5
    div.s $f6, $f4, $f5 # Divide o valor de $f4 pela constante F3 e armazena em $f6

    # Imprime mensagem de saída da temperatura em Celsius
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg2        # Carrega o endereço da mensagem em $a0
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Imprime o valor convertido em Celsius
    li $v0, 2           # Carrega o valor 2 em $v0 para imprimir um número de ponto flutuante
    mov.s $f12, $f6     # Move o valor de $f6 para $f12
    syscall             # Realiza a chamada do sistema para imprimir o valor

    j opcoes            # Salta para o início das opções

caso2:
    # Cálculo do enésimo termo da sequência de Fibonacci
    # Imprime pergunta sobre o enésimo termo de Fibonacci
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg3        # Carrega o endereço da mensagem em $a0
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Lê o número
    li $v0, 5           # Carrega o valor 5 em $v0 para ler um inteiro
    syscall             # Realiza a chamada do sistema para ler o número

    # Inicializando as variáveis
    move $t0, $v0       # Move o valor lido para $t0
    move $t1, $zero     # Inicializa $t1 com zero
    move $t2, $zero     # Inicializa $t2 com zero
    addi $t2, $t2, 1    # Adiciona o valor 1 em $t2
    move $t4, $zero     # Inicializa $t4 com zero
    addi $t4, $t4, 1    # Inicializa o contador do loop while em $t4 com 1

while:
    bge $t4, $t0, saida # Compara se o contador $t4 é maior ou igual ao valor lido $t0, se sim, salta para o rótulo saida
    add $t3, $t1, $t2   # Calcula a soma de $t1 e $t2 e armazena em $t3

    # Atualizando as variáveis
    move $t1, $t2       # Move o valor de $t2 para $t1
    move $t2, $t3       # Move o valor de $t3 para $t2

    # Atualizando o contador
    addi $t4, $t4, 1    # Adiciona 1 ao contador $t4

    # Salto para o início do loop while
    j while

saida:
    # Imprime a mensagem de saída do enésimo termo
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg4        # Carrega o endereço da mensagem em $a0
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Imprime o termo N da sequência de Fibonacci
    li $v0, 1           # Carrega o valor 1 em $v0 para imprimir um inteiro
    move $a0, $t1       # Move o valor armazenado em $t1 para $a0
    syscall             # Realiza a chamada do sistema para imprimir o valor

    j opcoes            # Salta para o início das opções

caso3:
    # Cálculo do enésimo termo par
    # Imprime pergunta sobre o enésimo termo par
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg5        # Carrega o endereço da mensagem em $a0
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Lê o número
    li $v0, 5           # Carrega o valor 5 em $v0 para ler um inteiro
    syscall             # Realiza a chamada do sistema para ler o número

    # Reiniciar a variável $t1 para 0
    move $t1, $zero     # Move o valor zero para $t1

    # Cálculo do enésimo termo par
    move $t0, $v0       # Move o valor lido para $t0
    addi $t1, $t1, 2    # Adiciona 2 em $t1
    mul $t2, $t1, $t0   # Multiplica o valor de $t1 pelo valor de $t0 e armazena em $t2

    # Imprime mensagem sobre qual é o enésimo termo par
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg6        # Carrega o endereço da mensagem em $a0 (argumento para syscall)
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Imprime qual é o enésimo termo par
    li $v0, 1           # Carrega o valor 1 em $v0 para imprimir um inteiro
    move $a0, $t2       # Move o valor armazenado em $t2 para $a0 (argumento para syscall)
    syscall             # Realiza a chamada do sistema para imprimir o valor

    j opcoes            # Salta para o início das opções

caso4:
    # Encerrar o programa
    li $v0, 10          # Carrega o valor 10 em $v0 para realizar a chamada do sistema para sair
    syscall             # Realiza a chamada do sistema para sair
