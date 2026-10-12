.data
	tableau: .word 2, 6, 7, 20, 3, 7, 8, 10, 11, 9
.text


	# compter_pairs(tab, 0) = (tab[0] pair ? 1 : 0)
	# compteur_pairs(tab, i) = (tab[i] pair ? 1 : 0) + compter_pairs(tab, i-1)

main:
	la $a0, tableau		# a0 = tableau
	addi $a1, $a1, 9	# index = 9
	jal compte_nbr
	add $a0, $v0, $zero	# valeur sauver dans $v0

	li $v0, 1		# affiche la valeur
	syscall

	li $v0, 10
	syscall

compte_nbr:

	# PROLOGUE
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	sw $a1, 0($sp)

	# CAS DE BASE
	bne $a1, $zero, RECUR	# Si i != 0 Saut a recur
	lw $t0, 4($a0)		# lire la valeur dans $t0

	addi $t1, $zero, 2	# $t1 = 2
	div $t0, $t1		# tab / 2
	mfhi $t2		# sauver le reste

	addi $v0, $zero, 0
	bne $t2, $zero, FIN_BASE
	addi $v0, $zero, 0
FIN_BASE:
	j fin

RECUR:
	# CAS RECURSIF
	sll $t0, $a1, 2		# $t0 = i x 4
	add $t1, $t0, $a0	# $t1 = 4i + adresse memoire
	lw $t2, 0($t1)		# lire la valeur dans la $t2
	sw $t2, 0($sp)		# sauve dans la pile tab[i]

	addi $a1, $a1, -1	# i-1
	jal compte_nbr
	lw $t2, 0($sp)		# restaure la valeur tab[i]

	addi $t3, $zero, 2	# $t3 = 2
	div $t2, $t3		# tab[i] / 2
	mfhi $t4		# le reste O ou 1

	addi $t5, $zero, 0	# par default $t3 = 0
	bne $t4, $zero, IMPAIR	# if != 0 saute a impair
	addi $t5, $zero, 1	# $t5

IMPAIR:
	add $v0, $t5, $v0
	j fin

fin:

	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra




