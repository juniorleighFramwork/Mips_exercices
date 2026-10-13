.data
    # recherche_dichtomique(tab, bas, haut, x)
    #   SI bas > haut : retourner -1                      (pas trouvé)
    #   m = (bas + haut) / 2
    # SI tab[m] == x : retourner m
    # SINON SI tab[m] > x : retourner recherche_dictomique(tab, bas, m-1, x)
    # SINON : retourner recherche_dictomique(tab, m+1, haut, x)
    #
    # Parametres :
    #   $a0 = adresse de base du tableau (trié)
    #   $a1 = bas (indice de début)
    #   $a2 = haut (indice de fin)
    #   $a3 = x (élément recherché)
    # Retour :
    #   $v0 = indice de x dans tab, ou -1 si absent
    #
    # Example : tab = {1, 3, 4, 6, 8, 9, 11}, bas = 0, haut = 6, x = 4
    # Attendu : $v0 = 2

    TAB: .word 1, 3, 4, 6, 8, 9, 11
.text
  main:

      la $a0, TAB                       # $a0 = adresse de base du tableau (trié)
      addi $a1, $zero, 0                # $a1 = bas (indice de début)
      addi $a2, $zero, 6                # $a2 = haut (indice de fin)
      addi $a3, $zero, 4                # $a3 = x (élément recherché)

      jal RECHERCHE_DICHOTOMIQUE          # Appel fonction
      add $a0, $v0, $zero               # Valeur de retour de resultat

      li $v0, 1                         # Affiche le resultat
      syscall

      li $v0, 10                        # Program End
      syscall

  RECHERCHE_DICHOTOMIQUE:
      # PROLOGUE
      # Reserver de la place dans la pile ou stocker les evenements.

      addi $sp, $sp, -12                # Reserve 12 octets dans la pile
      sw $ra, 8($sp)                    # Sauver la valeur de retour
      sw $a1, 4($sp)                    # Sauver la valeur de l'indice DE BAS

      # CAS DE BASE
      sgt $t0, $a1, $a2                 # Si bas > haut : 0 ou 1 (1 si oui , 0 non)
      beq $t0, $zero, RECUR             # Si $t0 == 0 SAUT A RECUR
      addi $v0, $zero, -1               # Sinon Not found
      j END

  RECUR:
    # CAS RECURSIF
      add $s0, $a1, $a2                 # $s0 = bas + haut
      addi $t1, $zero, 2                # $t1 = 2
      div  $s0, $t1                     # (bas + haut) / 2
      mflo $s1                          # m

      sll $s2, $s1, 2                   # ix4 = $s2
      add $s3, $s2, $a0                 # adress memory tab[m]
      lw $t2, 0($s3)                    # tab[m]
      sw $t2, 0($sp)                    # Sauver dans la pile
      lw $t2, 0($sp)                    # Load the value depuis la pile

      beq $t2, $a3, FIND                # if tab[m] == x : sinon retourn m
      sgt $t5, $t2, $a3                 #  si tab[m] > x 1 ou 0 sinon less
      bne $t5, $zero, GREAT             # si $t5 != 0 Saut a Great
      add $a1, $s1, 1                   # BAS = m+1 CHERCHE
      jal RECHERCHE_DICHOTOMIQUE
      j END

  GREAT:
      addi $a2, $s1, -1                 # HAUT = m-1
      jal RECHERCHE_DICHOTOMIQUE
      j END

  FIND:
      add $v0, $s1, $zero               # retourne m
      j END

  END:
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra
