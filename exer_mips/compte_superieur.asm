.data
    # compte_superieur(tab, 0, x) = (tab[0] > x ? 1 : 0)
    # compte_superieur(tab, i, x) = (tab[i] > x ? 1 : 0) + compte_superieur(tab, i-1, x)

    tab:    .word 3, 8, 1, 9, 4, 2

.text
    # Function recursive qui compte le nombre d'elements du tableau strictement superieur
    # a une valeur x donnée
  main:

    la $a0, tab             # Tab = $a0
    addi $a1, $zero, 5      # i = 5
    addi $a2, $zero, 4      # x = 4
    jal compte_superieur    # appel fonction
    add $a0, $v0, $zero     # sauver le resultat $v0

    li $v0, 1               # affiche resultat
    syscall

    li $v0, 10              # fin programme
    syscall

compte_superieur:
    # PROLOGUE

    addi  $sp, $sp, -12     # reserve des place dans la pile
    sw $ra, 8($sp)          # sauve la valeur de retour
    sw $a0, 4($sp)          # sauve l'argument du tab
    sw $a1, 0($sp)          # sauve l'index

    # CAS DE BASE
    bne $a1, $zero, RECUR   # si i != 0 saute a recur
    lw $t0, 0($a0)          # lire la valeur tab[0]

    add $t1, $a2, $zero     # $t1 = x + zero
    sgt $t2, $t0, $t1       # 0 ou 1 si tab[0] > x
    beq $t2, $zero, PAS_SUP # if == 0 saute a pas sup
    addi $v0, $zero, 1       # $v0 = 0 + 1
    j fin
PAS_SUP:
    add $v0, $zero, $zero
    j fin

RECUR:
    # CAS RECURSIF

    sll $t1, $a1, 2         # i x 4 = $t1
    add $t2, $t1, $a0       # $t2 = 4i + addresse memoire

    lw $t3, 0($t2)          # lire tab[i] dans $t3
    sw $t3, 0($sp)          # on sauve dans la pile tab[i]

    addi $a1, $a1, -1       # on i-1
    jal compte_superieur
    lw $t3, 0($sp)          # Restaure la valeur tab[i]

    add $t4, $a2, $zero     # $t4 = x + zero
    sgt $t5, $t3, $t4       # O ou 1 : tab[i] > x
    beq $t5, $zero, Pas_SUP # if not sup saute
    add $v0, $v0, 1         # superieur : on ajoute 1 au resultat deja dans $v0 
    j fin

Pas_SUP:                    # pas superieur : $v0 ne doit pas changer
    j fin

fin:
    # EPILOGUE
    lw $ra, 8($sp)          # on restaure la valeur de retour
    addi $sp, $sp, 12       # on libere
    jr $ra
