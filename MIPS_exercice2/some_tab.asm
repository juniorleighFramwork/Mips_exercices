  # somme_recursivie(tab, i , n)
      #   SI i == 0 : retourne 0
      # SINON : retourne tab[i] + somme_recursive(tab, i+1, n)
      #
      # Parametres :
      #   $a0 = adress de base du tableau
      #   $a1 = i (indice courant, commence à 0)
      #   $a2 = n (longueur du tableau)
      # Retour :
      #  $v0 n (longueur du tableau)
      # Retour :
      #   $v0 = somme de tab[i.. n-1]
      #
      # Exemple : tab = { 4, 8, 1, 9}, i = 0, n = 4
      # Attention : $v0 = 22

.data
    TAB: .word 4, 8, 1, 9
.text
  main:

      la $a0, TAB               # TAB = $a0
      addi $a1, $zero, 0        # i = 0
      addi $a2, $zero, 4        # n = 4 (0 -> 4)

      jal SOMME_TAB
      add $a0, $v0, $zero       # Sauver la veleur du result retour

      li $v0, 1                 # Print result
      syscall

      li $v0, 10                # Program END
      syscall

  SOMME_TAB:
      # PROLOGUE
      addi $sp, $sp, -12        # Reserve de la place dans la pile
      sw $ra, 8($sp)            # Sauver la valeur de retour
      sw $a0, 4($sp)            # La valeur de tab

      # CAS DE BASE
      bne $a1, $a2, RECUR     # If i != n SAUT A RECUR
      add $v0, $zero, 0
      j END

  RECUR:
      # CAS RECURSIF
      # SINON : retourne tab[i] + somme_recursive(tab, i+1, n)
      sll $t0, $a1, 2           # i x 4 = $t0
      add $t1, $t0, $a0         # Memory adress = $t1
      lw $t2, 0($t1)            # Read the first value from tab[i]
      sw $t2, 0($sp)            # Save the value in the PILE

      addi $a1, $a1, 1          # i = i + 1
      jal SOMME_TAB
      lw $t3, 0($sp)            # Load the value from $t3
      add $v0, $v0, $t3
      j END

  END:
      lw $ra, 8($sp)            # load the value
      lw $a0, 4($sp)
      addi $sp, $sp, 12         # Libere l'espace
      jr $ra
