.data
# compte_puissances_de_2(n)
#  Compte combien de fois on peut diviser n par 2 avant d'atteindre 1
#  (hypothese : n est une puissance de 2, ex: 16 -> 4 divisions)
#
#   SI n == 1 : retourner 0
#   SINON : retourner 1 + compte_puissances_de_2(n / 2)
#
# Parametres:
#   $a0 = n
# Retour:
#   $v0 = nombre de divisions par 2 nécessaires
#
# Exemple : n = 16
# Attendu : $v0 = 4

.text
  main:

      addi $a0, $zero, 16                           # $a0 = 16
      jal compte_puissances_de_2
      add $a0, $v0, $zero

      li $v0, 1
      syscall

      li $v0, 10
      syscall

  compte_puissances_de_2:
    # PROLOGUE

    addi $sp, $sp, -8
    sw $ra, 4($sp)


    addi $t0, $zero, 1                     # $t0 = 0
    bne $a0,$t0, RECUR                     # si $a0 != 1 Saut a recur
    add $v0, $zero, 0                     # sinon 0
    j END

  RECUR:

    # CAS RECURSIVE
    addi $t3, $zero, 2                    # $t3 = 2
    div $a0, $t3                          # n / 2
    mflo $t4                              # $t4 = n / 2

    add $a0, $zero, $t4                   # n = zero, (n/2)
    jal compte_puissances_de_2
    add $v0, $v0, 1                       # retourne 1
    j END

  END:
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
