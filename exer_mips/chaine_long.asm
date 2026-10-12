.data
    # Calcule la longueur d'une chaine
    # Version iteration
    # TANT QUE chaine[longueur] != '\0' :
    #   longueur = longueur + 1
    # retourne longueur

    CHAINE:   .asciiz "chien"
.text
  main:

      la $a0, CHAINE      # $a0 = CHAINE
      addi $a1, $zero, 0  # longueur = 0

  LOOP:
      add $t0, $a0, $a1   # Calculer l'adresse du caracter courant
      lb $t1, 0($t0)      # lire chaque valeur de la chaine
      
      beq $t1, $zero, FIN_LOOP  # Si cette caracter qu'on vient de lire est egal zero fin sinon continue
      addi $a1,$a1, 1
      j LOOP

  FIN_LOOP:
      add $v0, $a1, $zero
      j END

  END:

      add $a0, $v0, $zero
      li $v0, 1
      syscall

      li $v0, 10
      syscall
