.data
	intro : .asciiz "Forneca um numero decimal simples: "
	final: .asciiz "Peso final: "
	quebralinha: .asciiz "              "
	zero: .float 0.0
	um: .float 1.0
	dois: .float 2.0
	taxaAprendizado: .float 0.005

.text
	# $f12, $f13 : peso 1 e 2 respectivamente
	# $f1 : zero
	# $f2 : saida desejada
	# $f3 : aux peso1
	# $f4 : aux peso2
	# $f6 : saida neuronio
	# $f7 : erro
	# $f8 : taxa de aprendizado
	# $f9: 0.0
	# $f10: 1.0
	# $f11: 2.0

		
			# ETAPA 1
	li $v0, 4		# imprimir String ou char
	la $a0, intro		# carregar intro
	syscall			# chamar sistema para impressao
	
	li $v0, 6		# recolher valor float
	syscall			# chamar sistema para recolher valor			VALOR ARMAZENADO EM $f0
	
	lwc1 $f1, zero		# carregar zero em $f1					AUXILIAR PARA SOMA
	add.s $f12, $f1, $f0	# armazenar valor recolhido				PESO 1
	
	li $v0, 4		# imprimir String ou char
	la $a0, intro		# carregar intro
	syscall			# chamar sistema para impressao
	
	li $v0, 6		# recolher valor float
	syscall			# chamar sistema para recolher valor 			VALOR ARMAZENADO EM $f0
	
	add.s $f13, $f1, $f0	# armazenar valor recolhido				PESO 2
	
			# ETAPA 2
	addi $t0, $t0, 0
	lwc1 $f9, zero		# i
	lwc1 $f10, um		# aux i(float)
	lwc1 $f11, dois
	FOR:
	beq $t0, 20, FIM
	mul.s $f3, $f9, $f11 	# saida Desejada = i * 2
	mul.s $f4, $f12, $f9    # peso1 * i
	mul.s $f5, $f13, $f9	# peso2 * i
	add.s $f6, $f4, $f5	# (peso1*i) + (peso2*i)
	sub.s $f7, $f3, $f6	# erro = saida desejada - saida neuronio
	lwc1 $f8, taxaAprendizado # taxaAprendizado = 0.005
	mul.s $f8, $f8, $f9	# taxa * i
	mul.s $f7, $f7, $f8	# erro * (taxa *i)
	add.s $f12, $f12, $f7 	# peso 1 + (erro * taxa * i)
	add.s $f13, $f13, $f7 	# peso 2 + (erro * taxa * i)
	addi $t0, $t0, 1	# i++(int)
	add.s $f9, $f9, $f10	# i++(float)
	j FOR			# pular para FOR
	FIM:
			# ETAPA 3
			
	li $v0, 4		# imprimir String ou char
	la $a0, final		# carregar final
	syscall			# chamar sistema para imprimir
	
	li $v0, 2		# imprimir float
	syscall			# chamar sistema para imprimir
	
	li $v0, 4		# imprimir String ou char
	la $a0, quebralinha	# carregar quebralinha
	syscall			# chamar sistema para imprimir
	 
	li $v0, 4		# imprimir String ou char
	la $a0, final		# carregar final 
	syscall 		# chamar sistema para imprimir
	
	li $v0, 2		# imprimir float
	add.s $f12, $f13, $f1 	# carregar peso2 no $f12
	syscall			# chamar sistema para imprimir
