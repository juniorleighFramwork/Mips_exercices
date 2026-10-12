.data
    # Faire la somme les nombre dans le tableau
    tab: .word 2, 3, 1, 10, 12, 7

.text
main:
    la $a0, tab               # $a0 = tab
    addi $a1, $zero, 5        # index = 5
    jal somme_tab
    add $a0, $v0, $zero

    li $v0, 1
    syscall

    li $v0, 10
    syscall

somme_tab:
  # PROLOGUE


  addi $sp, $sp, -16           # RESERVER DANS LA PILE
  sw $ra, 12($sp)
  sw $a0, 8($sp)
  sw $a1, 4($sp)


  # CAS DE BASE
  bne $a1, $zero, RECUR     # if i != 0 saut a recur
  lw $v0, 0($a0)            # $v0 = tab[0]

  j fin

RECUR:

  # CAS RECURSIF
  sll $t0, $a1, 2           # i x 4 = $t1
  add $t1, $t0, $a0         # adresse memoire avec valeur = $t1 + $a0
  lw $t2, 0($t1)
  sw $t2, 0($sp)

  addi $a1, $a1, -1
  jal somme_tab
  lw $t2, 0($sp)

  add $v0, $t2, $v0

fin:

  lw $ra, 12($sp)
  addi $sp, $sp, 16
  jr $ra
