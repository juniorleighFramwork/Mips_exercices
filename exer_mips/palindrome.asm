.data
    # Etape 1 : CALCULER LA LONGUEUR
    # ETape 2 : i = 0, j = longueur - 1
    # TANT QUE i < j :
    #   SI chaine[i] != chaine[j] : retourne 0 (pas de palindrome)
    #   i = i + 1
    #   j = j - 1
    # retourn 1 (palindrome)

    # verifier si une chaine est un palindrome

    CHAINE: .asciiz "CHIEN"
.text
  main:

      la $a0, CHAINE
      addi $a1, $zero, 0            # longeur = 0

  LOOP:
      add $t0, $a0, $a1             # memoire adress
      lb $t1, 0($t0)

      beq $t1, $zero, End_COMPT
      add $a1, $a1, 1
      j LOOP

  End_COMPT:
      add $v0, $a1, $zero

      addi $a2, $zero, 0            # i = 0
      addi $a3, $a1, -1             # j = longueur -1
      j LOOP_COMPT

  LOOP_COMPT:
      slt $t0, $a2, $a3             # i < j
      bne $t0, $zero, IS_LESS      # Si i != 0 SAUT IS LESS
      add $v0, $zero, 1             # sinon retourn 1 (PALINDROME)
      J END
  IS_LESS:
      add $t2, $a0, $a2             # $t2 = adresse memoire
      lb $t3, 0($t2)                # tab[i]

      add $t4, $a0, $a3             # $t4 = adresse memoire
      lb $t5, 0($t4)                # tab[j]

      bne $t3, $t5, IS_NOT_EQAUL    # tab[i] != tab[j] saut is not equal
      addi $a2, $a2, 1               # i = i + 1
      addi $a3, $a3, -1              # j = j - 1

      j LOOP_COMPT
  IS_NOT_EQAUL:
      add $v0, $zero, 0             # sinon retourn 0 (pas de palindrome)
    j END

  END:
      add $a0, $v0, $zero
      li $v0, 1
      syscall
      li $v0, 10
      syscall
