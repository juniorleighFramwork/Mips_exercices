.data
    # compte_occurrences(tab, 0, x) = (tab[0] == x ? 1 : 0)
    # compte_occurrences(tab, i, x) = (tab[i] == x ? 1 : 0) + compte_occurrences(tab, i-1, x)
    # Fonction récursive qui compte combien de fois la valeur x apparait dans le tableau

    TAB:    .word 4, 1, 4, 9, 4, 2

.text
main:

    la $a0, TAB
    addi $a1, $zero, 5
    addi $a2, $zero, 4

    jal compte_occurrences
    add $a0, $v0, $zero

    li $v0, 1
    syscall

    li $v0, 10
    syscall

compte_occurrences:
    #PROLOGUE

    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $a0, 8($sp)
    sw $a1, 4($sp)

    # CAS DE BASE
    bne $a1, $zero, RECUR       # IF i != 0 saaut a recur
    lw $t0, 0($a0)

    add $t2, $a2, $zero
    beq $t0, $t2, EQUAL
    addi $v0, $zero, 0
    j fin

EQUAL:
    addi $v0, $zero, 1
    j fin

RECUR:

  # CAS RECUR
  sll $t0, $a1, 2
  add $t2, $t0, $a0
  lw $t3, 0($t2)
  sw $t3, 0($sp)

  addi $a1, $a1, -1
  jal compte_occurrences
  lw $t4, 0($sp)

  add $t5, $a2, $zero
  bne $t4, $t5, SI_pas_equal
  add $v0, $v0, 1

SI_pas_equal:
    j fin

fin:

    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
