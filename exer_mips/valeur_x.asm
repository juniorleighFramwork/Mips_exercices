.data
    # VERSION ITERATION
    # i = 0
    # TANT QUE i < n :
    #   SI tab[i] == x : retourne i (sortie enticipé)
    #   i = i + 1
    # retourn -1 (si jamais trouvé)

    TAB:  .word 3, 8, 1, 11, 4, 15
.text
  main:


    la $a0, TAB             # ADRESSE DE TAB
    addi $a1, $zero, 6      # NBR ELEMENT DANS LE TAB
    addi $a2, $zero, 11    # VALEUR RECHERCHE (X)
    addi $a3, $zero, 0      # i = 0

  LOOP:

  # PROLOGUE
    slt $t0, $a3, $a1       # if i < n : 0 ou 1
    beq $t0, $zero, GREAT   # i >= 0 SAUT a equa
    sll $t1, $a3, 2         # i x 4 = $t1
    add $t2, $t1, $a0       # $t2 = adress memoire
    lw $t3, 0($t2)          # Lire la premiere valeur de tab[i]

    beq $t3, $a2, FIND      # IF 11 == 11 saute a find et met fin
    addi $a3, $a3, 1        # sinon i = i + 1
    j LOOP

  FIND:
    add $v0, $a3, $zero
    j fin

  GREAT:
    addi $v0, $zero, -1
    j fin

  fin:

    add $a0, $v0, $zero
    li $v0, 1
    syscall

    li $v0, 10
    syscall
