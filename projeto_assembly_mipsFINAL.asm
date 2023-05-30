################################################################################
# Nome do Projeto: Conversor de Temperaturas, Sequ�ncia de Fibonacci e En�simo Par em Assembly MIPS
#
# Autor(es): Christianny, Ingrid e Rodrigo
# Disciplina: Arquitetura e Organiza��o de Computadores
# Institui��o: Instituto Federal de Alagoas - IFAL
# Professor: Ivo Augusto Andrade Rocha Calado
#
# Descri��o:
# Este programa em Assembly MIPS realiza a convers�o de temperaturas de graus Fahrenheit (�F) para Celsius (�C);
# calcula os termos da sequ�ncia de Fibonacci;
# e determina o en�simo n�mero par, com base em uma entrada fornecida pelo usu�rio.
# O programa foi desenvolvido como parte do trabalho da disciplina de Arquitetura e Organiza��o de Computadores 
# do curso de Sistemas de Informa��o.
# O objetivo � demonstrar o conhecimento em linguagem Assembly MIPS e sua aplica��o para realizar opera��es matem�ticas simples.
#
# Arquivo: projeto_assembly_mips.asm
################################################################################


.data
    # Constantes utilizadas na convers�o de Fahrenheit para Celsius
    F1: .float 32.0     
    F2: .float 5.0        
    F3: .float 9.0  
    # String a ser exibida no Run I/O do Mars
    msg1: .asciiz "Indique a temperatura em Fahrenheit: " 
    msg2: .asciiz "A temperatura em Celsius �: "   
    msg3: .asciiz "Digite o en�simo termo da sequ�ncia de Fibonacci que voc� gostaria de saber: "
    msg4: .asciiz "O en�simo termo da sequ�ncia de Fibonacci �: " 
    msg5: .asciiz "Considerando 2 como o primeiro termo par. Digite o en�simo n�mero par que voc� gostaria de saber: "
    msg6: .asciiz "O en�simo termo par �: "     
    menu: .asciiz "\n1 - Fahrenheit -> Celsius \n2 - Fibonacci\n3 - En�simo termo par\n4 - Sair\n"
    msg_erro: .asciiz "\nOp��o inv�lida. Voltando ao menu.\n"
    opcao: .space 10
    newline: .asciiz "\n"
.text
opcoes:
    # Impress�o do menu
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string (c�digo do syscall para imprimir string)
    la $a0, menu        # Carrega o endere�o da string do menu em $a0 (argumento para syscall)
    syscall             # Realiza a chamada do sistema para imprimir o menu

    # Ler n�mero do menu
    #li $v0, 5           # Carrega o valor 5 em $v0 para ler a entrada, que esperamos que seja um inteiro, 
    #			com o c�digo do syscall 5 para ler um interger. 
   # syscall             # Realiza a chamada do sistema para a leitura
    
    # Ler n�mero do menu como uma string
    li $v0, 8           # Carrega o valor 8 em $v0 para ler a string
    la $a0, opcao      # Carrega o endere�o da vari�vel de entrada em $a0
    li $a1, 10          # Define o tamanho m�ximo da string como 10 (ajuste conforme necess�rio)
    syscall             # Realiza a chamada do sistema para a leitura da string

    # Verificar se a entrada � uma string vazia (primeiro caractere � zero)
    lb $t0, opcao        # Carrega o primeiro byte da string em $t0
    beqz $t0, caso0      # Se o primeiro byte for zero, salta para a rotina de erro

    # Converte a string para um n�mero inteiro
    li $t1, 0           # Inicializa $t1 para acumular o valor convertido
    li $t2, 0           # Inicializa $t2 para indicar o sinal do n�mero (positivo)

   loop_conversao:
    lbu $t3, 0($a0)      # Carrega o pr�ximo byte da string em $t3
    beqz $t3, condicionais  # Se o byte for zero, encerra a convers�o

    sub $t3, $t3, 48     # Converte o valor ASCII para o valor decimal
    blt $t3, $zero, condicionais  # Verifica se o valor convertido � negativo

    mul $t1, $t1, 10     # Multiplica o valor acumulado por 10
    add $t1, $t1, $t3    # Adiciona o valor atual ao valor acumulado

    addi $a0, $a0, 1     # Avan�a para o pr�ximo byte da string
    j loop_conversao     # Retorna ao in�cio do loop de convers�o

 condicionais: 
    # Condicionais do menu
    beq $t1, 1, caso1   # Se $t0 for igual a 1, salta para o caso1
    beq $t1, 2, caso2   # Se $t0 for igual a 2, salta para o caso2
    beq $t1, 3, caso3   # Se $t0 for igual a 3, salta para o caso3
    beq $t1, 4, caso4   # Se $t0 for igual a 4, salta para o caso4
    j caso0		  # Se $t0 for um inteiro diferente das op��es v�lidas, vai para o caso da mensagem de erro e posterior retorno ao menu

caso0:
	li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
	la $a0, msg_erro    # Carrega o endere�o da mensagem de erro em $a0 (argumento para syscall)
	syscall             # Realiza a chamada do sistema para imprimir a mensagem de erro

	j opcoes            # Retorna ao Menu
	
caso1:
    # Convers�o de Fahrenheit para Celsius
    # Imprime mensagem da temperatura em Fahrenheit
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg1        # Carrega o endere�o da mensagem em $a0 (argumento para syscall)
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # L� o valor em Fahrenheit
    li $v0, 6           # Carrega o valor 6 em $v0 para ler um n�mero de ponto flutuante
    syscall             # Realiza a chamada do sistema para ler o valor

    # Convers�o do valor de Fahrenheit para Celsius
    lwc1 $f1, F1        # Carrega o valor da constante F1 em $f1
    sub.s $f2, $f0, $f1 # Subtrai o valor lido de Fahrenheit pela constante F1 e armazena em $f2

    lwc1 $f3, F2        # Carrega o valor da constante F2 em $f3
    mul.s $f4, $f3, $f2 # Multiplica o valor de $f2 pela constante F2 e armazena em $f4

    lwc1 $f5, F3        # Carrega o valor da constante F3 em $f5
    div.s $f6, $f4, $f5 # Divide o valor de $f4 pela constante F3 e armazena em $f6

    # Imprime mensagem de sa�da da temperatura em Celsius
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg2        # Carrega o endere�o da mensagem em $a0
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Imprime o valor convertido em Celsius
    li $v0, 2           # Carrega o valor 2 em $v0 para imprimir um n�mero de ponto flutuante
    mov.s $f12, $f6     # Move o valor de $f6 para $f12
    syscall             # Realiza a chamada do sistema para imprimir o valor

    j opcoes            # Salta para o in�cio das op��es

caso2:
    # C�lculo do en�simo termo da sequ�ncia de Fibonacci
    # Imprime pergunta sobre o en�simo termo de Fibonacci
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg3        # Carrega o endere�o da mensagem em $a0
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # L� o n�mero
    li $v0, 5           # Carrega o valor 5 em $v0 para ler um inteiro
    syscall             # Realiza a chamada do sistema para ler o n�mero

    # Inicializando as vari�veis
    move $t0, $v0       # Move o valor lido para $t0    
    li $t1, 1           # Inicializa $t1 com zero (primeiro termo)
    li $t2, 2           # Inicializa $t2 com 1 (segundo termo)
    li $t4, 1           # Inicializa $t4 com 2 (contador)
	
while:
    bge $t4, $t0, saida # Compara se o contador $t4 � maior ou igual ao valor lido $t0, se sim, salta para o r�tulo saida
    add $t3, $t1, $t2   # Calcula a soma de $t1 e $t2 e armazena em $t3

    # Atualizando as vari�veis
    move $t1, $t2       # Move o valor de $t2 para $t1
    move $t2, $t3       # Move o valor de $t3 para $t2

    # Atualizando o contador
    addi $t4, $t4, 1    # Adiciona 1 ao contador $t4

    # Salto para o in�cio do loop while
    j while

    j opcoes            # Salta para o in�cio das op��es

saida:
    # Imprime a mensagem de sa�da do en�simo termo
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg4        # Carrega o endere�o da mensagem em $a0
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Imprime o termo N da sequ�ncia de Fibonacci
    li $v0, 1           # Carrega o valor 1 em $v0 para imprimir um inteiro
    move $a0, $t1       # Move o valor armazenado em $t1 para $a0
    syscall             # Realiza a chamada do sistema para imprimir o valor

    j opcoes            # Salta para o in�cio das op��es

caso3:
    # C�lculo do en�simo termo par
    # Imprime pergunta sobre o en�simo termo par
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg5        # Carrega o endere�o da mensagem em $a0
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # L� o n�mero
    li $v0, 5           # Carrega o valor 5 em $v0 para ler um inteiro
    syscall             # Realiza a chamada do sistema para ler o n�mero

    # Reiniciar a vari�vel $t1 para 0
    move $t1, $zero     # Move o valor zero para $t1

    # C�lculo do en�simo termo par
    move $t0, $v0       # Move o valor lido para $t0
    addi $t1, $t1, 2    # Adiciona 2 em $t1
    mul $t2, $t1, $t0   # Multiplica o valor de $t1 pelo valor de $t0 e armazena em $t2

    # Imprime mensagem sobre qual � o en�simo termo par
    li $v0, 4           # Carrega o valor 4 em $v0 para imprimir uma string
    la $a0, msg6        # Carrega o endere�o da mensagem em $a0 (argumento para syscall)
    syscall             # Realiza a chamada do sistema para imprimir a mensagem

    # Imprime qual � o en�simo termo par
    li $v0, 1           # Carrega o valor 1 em $v0 para imprimir um inteiro
    move $a0, $t2       # Move o valor armazenado em $t2 para $a0 (argumento para syscall)
    syscall             # Realiza a chamada do sistema para imprimir o valor

    j opcoes            # Salta para o in�cio das op��es

caso4:
    # Encerrar o programa
    li $v0, 10          # Carrega o valor 10 em $v0 para realizar a chamada do sistema para sair
    syscall             # Realiza a chamada do sistema para sair
