.data
F1: .float 32.0        # Constante representando o valor 32.0 em ponto flutuante (Fahrenheit)
F2: .float 5.0         # Constante representando o valor 5.0 em ponto flutuante
F3: .float 9.0         # Constante representando o valor 9.0 em ponto flutuante
prompt_f: .asciiz "Indique a temperatura em Fahrenheit: "    # Mensagem de solicitação da temperatura em Fahrenheit
mensagem: .asciiz "A temperatura em Celsius é: "             # Mensagem de exibição da temperatura em Celsius

.text
main:
	li $v0, 4             # Carrega o valor 4 em $v0 para realizar a chamada do sistema para imprimir uma string
	la $a0, prompt_f      # Carrega o endereço da mensagem prompt_f em $a0 para ser impressa
	syscall               # Realiza a chamada do sistema para imprimir a mensagem
	
	li $v0, 6             # Carrega o valor 6 em $v0 para realizar a chamada do sistema para ler um número de ponto flutuante
	syscall               # Realiza a chamada do sistema para ler a temperatura em Fahrenheit e armazenar em $f0
	
	lwc1 $f1, F1          # Carrega o valor da constante F1 em $f1
	sub.s $f2, $f0, $f1   # Subtrai o valor da temperatura em Fahrenheit ($f0) pelo valor de F1 ($f1) e armazena em $f2
	
	lwc1 $f3, F2          # Carrega o valor da constante F2 em $f3
	mul.s $f4, $f3, $f2   # Multiplica o valor de F2 ($f3) pelo resultado anterior ($f2) e armazena em $f4
	
	lwc1 $f5, F3          # Carrega o valor da constante F3 em $f5
	div.s $f6, $f4, $f5   # Divide o resultado anterior ($f4) pelo valor de F3 ($f5) e armazena em $f6
	
	li $v0, 4             # Carrega o valor 4 em $v0 para realizar a chamada do sistema para imprimir uma string
	la $a0, mensagem      # Carrega o endereço da mensagem mensagem em $a0 para ser impressa
	syscall               # Realiza a chamada do sistema para imprimir a mensagem
	
	li $v0, 2             # Carrega o valor 2 em $v0 para realizar a chamada do sistema para imprimir um número de ponto flutuante
	mov.s $f12, $f6       # Move o valor da temperatura em Celsius ($f6) para $f12 para ser impresso
	syscall               # Realiza a chamada do sistema para imprimir a temperatura em Celsius

	