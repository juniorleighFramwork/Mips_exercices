.data
      # compte_pairs(tab, 0) = (tab[0] pair ? 1 : 0)
      # compte_pairs(tab, i) = (tab[i] pair ? 1 : 0) + compte_pairs(tab, i-1)
      # Fonction recursive qui compte le nombre d'element pair dans un tableau
      tab:  .word 2, 8, 1, 4, 7, 2
.text
main:

      la $a0, tab
      addi $a1, $zero, 5
      jal compte_pairs
      add $a0, $v0, $zero

      li $v0, 1
      syscall

      li $v0, 10
      syscall

compte_pairs:

      # PROLOGUE
      addi $sp, $sp, -16
      sw $ra, 12($sp)
      sw $a0, 8($sp)
      sw $a1, 4($sp)


      # CAS DE BASE
      bne $a1, $zero, RECUR     # if i != 0
      lw $t0, 0($a0)

      andi $t1,$t0, 1
      bne $t1, $zero, PAIR
      add $v0, $zero, 1         # sinon 0 + 1
      j fin

PAIR:
      add $v0, $zero, $zero
      j fin

RECUR:
      sll $t0, $a1, 2
      add $t1, $t0, $a0
      lw $t2, 0($t1)
      sw $t2, 0($sp)

      addi $a1, $a1, -1
      jal compte_pairs
      lw $t3, 0($sp)

      andi $t4, $t3, 1
      bne $t4, $zero, IMPAIR
      addi $v0, $v0, 1
      j fin

IMPAIR:
      j fin

fin:

      lw $ra, 12($sp)
      addi $sp, $sp, 16
      jr $ra
