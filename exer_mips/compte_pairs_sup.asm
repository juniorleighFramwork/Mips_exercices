.data
    # compte_pairs_superieurs(tab, 0, x) = (tab[0] pair ET tab[0] > x ? 1 : 0)
    # compte_pairs_superieurs(tab, i, x) = (tab[i] pair ET tab[i] > x ? 1 : 0) + compte_pairs_superieurs(tab, i-1, x)
    TAB: .word  2, 8, 1, 4, 10, 3
.text
main:

    la $a0, TAB             # $a0 = TAB dns le registe
    addi $a1, $zero, 5      # $index = 5
    addi $a2, $zero, 3      # x = 3
    jal compte_pairs_superieurs
    add $a0, $v0, $zero

    li $v0, 1
    syscall

    li $v0, 10
    syscall

compte_pairs_superieurs:

    # PROLOGUE
    addi $sp, $sp, -16      # Reserver de la place dans la place
    sw $ra, 12($sp)         # Sauver la valeur de retour dans la pile
    sw $a0, 8($sp)          # Sauver l'argument du TAB
    sw $a1, 4($sp)          # Sauver l'argument de l'index

    # FUNCTION RECURSIVE QUI COMPTE LES ELEMENTS QUI SONT A LA FOIS PAIRS ET STRICTEMENT SUPERIEURS A X
    # CAS DE BASE
    bne $a1, $zero, RECUR   # Si i != 0 SAUT a RECUR
    lw $t0, 0($a0)          # Lire la valeur de tab[0] dans $t0

    andi $t1, $t0, 1        # 0 ou 1 : si tab[0] = 2 est pair = 0
    xori $t1, $t1, 1        # inverse : $t1 = 1 si pair, 0, si impair
    sgt $t2, $t0, $a2       # 0 ou 1 : si tab[2] > 3 = 0

    and $t3, $t1, $t2       # $t3 si oui = 1 sinon 0
    beq $t3, $zero, PAIR_X  # Si $t3 == 0 Saut
    add $v0, $zero, 1   
    j fin

PAIR_X:
    add $v0, $zero, $zero
    j fin

RECUR:
    # CAS RECURSIVE
    sll $t0, $a1, 2         # index x 4 = $t0
    add $t1, $t0, $a0       # $t1 = 4i + adresse memoire
    lw $t2, 0($t1)          # Lire la valeur $t1 dans $t2
    sw $t2, 0($sp)          # Sauver dans la pile

    addi $a1, $a1, -1       # i - 1
    jal compte_pairs_superieurs
    lw $t3, 0($sp)

    andi $t4, $t3, 1        # 0 ou 1 : si pair on sauve 0 sinon 1
    xori $t4, $t4, 1        # inverse : $t4 = 1 si pair , 0 si impair
    sgt $t5, $t3, $a2       # si $t3 > x
    and $t6, $t4, $t5       # cette condition veut 1 si les deux sont true sinon 0
    beq $t6, $zero, IMPA_X  # SI $t6 != 0 saut
    add $v0, $v0, 1         # sinon $v0 = result + 1
    j fin

IMPA_X:
    j fin

fin:
    # EPILOGUE
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
