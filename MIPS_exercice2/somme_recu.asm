.data
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

      TAB:  .word 4, 8, 1, 9
.text
  main:

      la $a0, TAB             # $a0 = TAB
      addi $a1, $zero, 0      # i = 0
      addi $a2, $zero, 4      # n = 4

      jal somme_recursive
      add $a0, $v0, $zero     # Save the value

      li $v0, 1
      syscall

      li $v0, 10
      syscall

  somme_recursive:

      # PROLOGUE

      addi $sp, $sp -12         # Reserve de la place dans la pile (3 mots)
      sw $ra, 8($sp)            # Save la valeur de retour dans la pile
      sw $a0, 4($sp)            # Save l'argument dans la pile

      bne $a1, $a2, RECUR       # i != n SAUT
      add $v0, $zero, 0         # sinon 0
      j END
  RECUR:
      # CAS recursive

      sll $t0, $a1, 2           # ix4
      add $t1, $t0, $a0         # adress memory
      lw $t2, 0($t1)            # lire tab[i]
      sw $t2, 0($sp)            # save dans la pile

      addi $a1, $a1, 1           # i = i + 1 pour l'appel suivant
      jal somme_recursive       # appel focntion : somme_recursive(tab, i+1, n)

      # Retour de recursion
      lw $t3, 0($sp)            # lire la valeur tab[i]
      add $v0, $v0, $t3         # $v0 = $v0 + $t3
      j END
  END:

      lw $ra, 8($sp)
      lw $a0, 4($sp)
      addi $sp, $sp, 12
      jr $ra
