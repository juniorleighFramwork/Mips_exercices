.data
    # Etape 1 : CALCULER LA LONGUEUR
    # ETape 2 : i < 0, j = longueur - 1
    # TANT QUE i < j :
    #   SI chaine[i] != chaine[j] : retourne 0 (pas de palindrome)
    #   i = i + 1
    #   j = j - 1
    # retourn 1 (palindrome)

    # verifier si une chaine est un palindrome

    CHAINE: .asciiz "radar"
.text
  main:

      la $a0, CHAINE              # $a0 = CHAINE
      addi $a1, $zero, 0          # longueur = 0

      # calculer la longueur de la chaine
      add $t0, $a0, $a1           # calculer ladresse courant
      lb $t1, 0($t0)              # lire de chaque byte

      addi $t4, $zero, 0          # default = 0
      addi $a2, $zero, 0          # i = 0
      slt $a3, $a2, $t4           # i < 0
      addi $t5, $t1, -1           # j = longueur -1

  LOOP:
      slt $t0, $a2, $t5           # i < j : 1 ou 0
      bne $t0, $zero, IS_LESS     # IF IT LESS SAUT A IS LESS
      add $v0, $zero, 1           # sinon retourn 1
      j END

  IS_LESS:
      add $t1, $a0, $a2           # adresse chaine
      lb $t2, 0($t1)              # lire la premire valeur
      bne  $t2, $t1, PAS_EUAL     # chaine[i] != chaine[j] saute
      addi $a2, $a2, 1            # i = I + 1
      addi $a3, $a3, -1           # j = j + 1
      j LOOP

  PAS_EUAL:
      add $a2, $a2, 1.           # pas palindrome
      j LOOP

  END:
      add $a0, $v0, $zero
      li $v0, 1
      syscall
      li $v0, 10
      syscall
