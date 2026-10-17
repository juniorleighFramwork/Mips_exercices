# Recherche dichotomique avec échec (-1)
# on te donne un tableau trié. Tu dois ecrire ou completer la fonction recursive de recherche dichotomique.
# Si l'element est trouvé, la fonction retourne son indice. Si elle n'est pas trouvé, elle doit retourner -1

.data
    TAB: .word 2, 5, 8, 12, 16, 23, 38
.text
  main:
      la $a0, TAB               # Adresse du TAB
      addi $a1, $zero, 0        # bas = 0
      addi $a2, $zero, 6        # haut = 6
      addi $a3, $zero, 10        # x = 5 (élément cherché)

      jal DICHOTOMIQUE
      move $a0, $v0             # Affiche le résultat
      li $v0, 1
      syscall

      li $v0, 10
      syscall

  DICHOTOMIQUE:
    # PROLOGUE : On ne sauvegarde que $ra (8 octets)
      addi $sp, $sp, -8
      sw $ra, 4($sp)          # Sauvegarde de l'adresse de retour

      # CAS DE BASE : SI bas > haut , retourne -1
      sgt $t0, $a1, $a2
      bne $t0, $zero, NOT_FOUND

      # CALCUL DU MILIEU : m = (bas + haut) / 2
      add $t1, $a1, $a2           # $t1 = bas + haut
      li $t2, 2
      div $t1, $t2
      mflo $t3                    # $t3 = m (milieu)

      # CHARGEMENT DE tab[m] et COMPARAISONS
      sll $t4, $t3, 2             # m * 4
      add $t5, $t4, $a0           # Adresse de tab[m]
      lw $t6, 0($t5)              # $t6 = tab[m]

      beq $t6, $a3, FOUND
      sgt $t7, $t6, $a3
      bne $t7, $zero, CHERCHE_GAUCHE

      # CHERCHE DROIT (bas = m + 1)
      add $a1, $t3, 1
      jal DICHOTOMIQUE
      j End

  CHERCHE_GAUCHE:
      # CHERCHE GAUCHE (haut = m - 1)
      add $a2, $t3, -1
      jal DICHOTOMIQUE
      j End

  FOUND:
      move $v0, $t3       # $v0 = m (indice trouvé)
      j End

  NOT_FOUND:
      addi $v0, $zero, -1 # Non trouvé -> -1
      j End

  End:
    # ÉPILOGUE
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
