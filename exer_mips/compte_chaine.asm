.data
    # VERSION ITERATION :
    # compteur = 0
    # i = 0
    # TANT QUE chaine[i] != '\0' :
    #   si chaine[i]== c : compteur = compteur + 1
    # i = i + 1
    # retourne compteur

    # Compteur de fois un caractere donné

    CHAINE:  .asciiz "mohammad"
.text
  main:

      la $a0, CHAINE                # $a0 = CHAINE
      addi $a1, $zero, 0            # compteur = 0
      addi $a2, $zero, 0            # i = 0
      addi $a3, $zero, 'a'          # x = 'a'

  LOOP:

      add $t0, $a0, $a2             # adresse de la chaine
      lb $t1, 0($t0)                # lis la premiere valeur de chaque byte
      bne $t1, $zero, Continue_LOOP # si tab[i] != '\Ø' Saut Continue loop
      add $v0, $a1, $zero
      j END

  Continue_LOOP:
      add $t2, $a0, $a2             # adresse de la chaine
      lb $t3, 0($t2)               # lire la premiere valeur du tab[i]
      beq $t3, $a3, Egal_c        # si tab[i] == 'c' Saut a it egal
      addi $a2, $a2, 1           # sinon i = i + 1
      j LOOP

  Egal_c:
      addi $a1, $a1, 1         # compte = compte + 1
      addi $a2, $a2, 1         # i = i + 1
      j LOOP
  END:
      add $a0, $v0, $zero
      li $v0, 1
      syscall

      li $v0, 10
      syscall
