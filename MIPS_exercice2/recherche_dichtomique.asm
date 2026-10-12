# Recherche_recursive(tab, i ,n x)
#   SI i == n : retourner -1      (pas trouvé, fin de tableau)
#   SINON SI tab[i] == x : retourner i    (trouvé)
#   SINON : retourner recherche_recursive(tab, i+1, n, x)
#
# parametres :
# $a0 = adresse de base du tableau
# $a1 = i (indice courant, commence à 0)
# $a2 = n (longueur du tab)
# $a3 = x (element recherché)
# retour :
# $v0 = indice de x dans tab, ou -1 si absent
#
# Exemple : tab = {4, 8, 1, 9}, i=0, n=4, x=1
# attendu : $v0 = 2

.data
    TAB: .word 4, 8, 1, 9
.text
  main:

    la $a0, TAB               # $a0 = TAB
    addi $a1, $zero, 0        # i = 0
    addi $a2, $zero, 4        # n = 4
    addi $a3, $zero, 1        # x = 1

    jal RECHERCH_DICHTO       # Appel fonction
    add $a0, $v0, $zero       # valeur de reour

    li $v0, 1                 # affiche result
    syscall

    li $v0, 10                # Program END
    syscall

#   Recherche_recursive(tab, i ,n x)
#   SI i == n : retourner -1      (pas trouvé, fin de tableau)
  RECHERCH_DICHTO:
    # PROLOGUE
    addi $sp, $sp, -12        # Reserver de la place dans la pile
    sw $ra, 8($sp)            # Sauver la valeur de retour
    sw $a1, 4($sp)            # Sauver la valeur de i

    # CAS DE BASE
    bne $a1, $a2, RECUR       # si i != n SAUT A RECUR
    addi $v0, $zero, -1       # Pas trouvé, Fin tableau
    j END

  RECUR:
    # CAS DE RECURSIVE
    # SINON SI tab[i] == x : retourner i    (trouvé)
    # SINON : retourner recherche_recursive(tab, i+1, n, x)

    sll $t0, $a1, 2           # i x 4 = $t0 (octet)
    add $t1, $t0, $a0         # adress memory (tab[i])
    lw $t2, 0($t1)            # READ THE FIRST VALUE TAB[i]
    sw $t2, 0($sp)            # Sauver dans la pile

    addi $a1, $a1, 1          # i = i + 1
    jal RECHERCH_DICHTO       # appel fonction
    lw $t3, 0($sp)            # Load value
    lw $t4, 4($sp)            # load i
    beq $t3, $a3, FIND        # If tab[i] == x : TROUVER
    j END

  FIND:
    add $v0, $t4, $zero         # TROUVER
    j END

  END:

    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra
