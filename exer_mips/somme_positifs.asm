.data

  # Ecris une fonction recursive qui prend un tableau d'entier et sa taille, et retourne la sommme
  # des elements positifs (on ignore les negatifs et le zero)
  # somme_positifs(tab, 0) = (tab[0] > 0 ? tab[0] : 0)
  # somme_positifs(tab, i) = (tab[i] > 0 ? tab[i] : 0) + somme_positifs(tab, i-1)

  tableau: .word 0, 2, 3, -1, 7, -4, 5

.text
  main:
      la $a0, tableau       # tab
      addi $a1, $zero, 6     # taille
      jal compt_positif
      add $a0, $v0, $zero

      li $v0, 1             # affiche le resultat
      syscall

      li $v0, 10            # fin de programme
      syscall

compt_positif:
    # PROLOGUE

    addi $sp, $sp, -12      # Reserver de la dans la pile
    sw $ra, 8($sp)          # Sauver la valeur de retour
    sw $a0, 4($sp)
    sw $a1, 0($sp)


    # CAS DE BASE
    bne $a1, $zero, RECUR   # si i !=0 saut a recur
    lw $t1, 0($a0)          # lire la valeur tab[0]

    addi $t2, $zero, 0      # set par default 0
    sgt $t3, $t1, $t2       # Si tab[0] > 0
    beq $t3, $zero, PAS_POSI
    add $v0, $t1, $zero     # Positif
    j fin

PAS_POSI:
    add $v0, $zero, $zero   # Pas positif
    j fin

RECUR:
    # Recursif
    sll $t0, $a1, 2         # $t0 = i x 4
    add $t1, $a0, $t0       # $t1 = tab + i =  adresse memoire,
    lw $t2, 0($t1)          # on lit la valeur tab[i] dans $t2
    sw $t2, 0($sp)          # on sauve dans la pile

    addi $a1, $a1, -1       # i-1
    jal compt_positif       # on appel fonction
    lw $t2, 0($sp)          # restaure tab[i]

    addi $t3, $zero, 0
    sgt $t4, $t2, $t3       # si tab[i] > 0 sauve dans $t4
    beq $t4, $zero, SOMME
    add $v0, $t2, $v0       # somme_positifs(tab, i) = (tab[i] > 0 ? tab[i] : 0) + somme_positifs(tab, i-1)
    j fin

SOMME:
    add $v0, $zero, $v0
    j fin
fin:
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra
