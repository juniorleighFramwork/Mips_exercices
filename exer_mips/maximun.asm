.data
      # maximum(tab, 0) = tab[0]
      # maximum(tab, i) = max(tab[i], maximum(tab, i-1))

      tab: .word 3, 8, 11, 9, 4, 2         # tab = { 3, 8, 1, 9, 4, 2  }

.text
main:

      la $a0, tab
      addi $a1, $zero, 5        # index = 5
      jal max_nbr
      add $a0, $v0, $zero

      li $v0, 1
      syscall

      li $v0, 10
      syscall

max_nbr:

      # PROLOGUE
      # Fonction recursive qui retourne la valeur max
      addi $sp, $sp, -16
      sw $ra, 12($sp)
      sw $a0, 8($sp)
      sw $a1, 4($sp)

      # CAS DE BASE
      bne $a1, $zero, RECUR     # Si i != 0 SAUT A RECUR
      lw $v0, 0($a0)            # lis la tab[0]
      j FIN

  RECUR:

      # CAS RECURSIF

      sll $t0, $a1, 2           # $t0 = i x 4 chaque index = 4 octet
      add $t1, $t0, $a0         # $t1 = ix4 + adresse memoire
      lw $t2, 0($t1)            # $t2 = tab[i]
      sw $t2, 0($sp)            # sauve dans la pile

      addi $a1, $a1, -1         # i - 1
      jal max_nbr
      lw $t3, 0($sp)            # lis la valeur tab[i]

      sgt  $t5, $t3, $v0        # 0 ou 1 : si tab[i] > $v0
      beq $t5, $zero, max       # If $t5 == 0 fin
      add $v0, $t3, $zero       # on sauv la valeur dans $v0

max:
      j FIN

FIN:
    # Epilogue

    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
