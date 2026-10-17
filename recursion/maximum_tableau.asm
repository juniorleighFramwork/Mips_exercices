.data
  # maximum_tableau(tab, n)
  #   SI == 1 : retourner tab[0]
  #   SINON : m = maximum_tab(tab, n-1)
  #         retourne le plus grand entre m et tab[n-1]
  #
  # Exemple : tab = [3,9, 2, 7], n = 4
  # Attendu : $v0 = 9

  TAB: .word 3, 9, 2, 7
.text
  main:

      la $a0, TAB
      addi $a1, $zero, 4

      jal maximum_tableau
      move $a0, $v0
      li $v0, 1
      syscall
      li $v0, 10
      syscall

  maximum_tableau:
    # PROLOGUE

    addi $sp, $sp, -8
    sw $ra, 4($sp)

    # cas de base
    addi $t0, $zero, 1
    bne $a1, $t0, RECUR     # TANT QUE n != 1 SAUT A RECUR
    lw $v0, 0($a0)         # Sinon tab[0]
    j End

  RECUR:
    addi $a1, $a1, -1       # n = n-1
    sll $t0, $a1, 2         # n x 4
    add $t1, $t0, $a0       # adress memoire
    lw $t1, 0($t1)          # tab[n-1]
    sw $t1, 0($sp)          # sauver dans la pile

    jal maximum_tableau
    lw $t2, 0($sp)          # tab[n-1]
    sgt $t3, $t2, $v0       # $t2 > $v0 , 1 sinon 0
    beq $t3, $zero, FIN     # if $t3 == 0 saut fin
    add $v0, $zero, $t2     # sinon sauve la valeur plus grand
    j End

  FIN:
    j End

  End:
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
