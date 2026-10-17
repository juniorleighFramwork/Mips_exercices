.data
  # somme(n)
  #   SI n == 0 : retourner 0
  #   SINON : retourner n + somme(n-1)
  #
  # Paramtres:
  #   $a0 = n
  # Retour:
  #   $v0 = somme des entiers de 1 a n
  #
  # Exemple : n = 4
  # Attendu : $v0 = 10
.text
  main:

      addi $a0, $zero, 4        # n = 4

      jal somme_n
      add $a0, $v0, $zero

      li $v0, 1
      syscall

      li $v0, 10
      syscall

  somme_n:
      # PROLOGUE

      addi $sp, $sp, -8
      sw $ra, 4($sp)
      sw $a0, 0($sp)

      addi $t0, $zero, 0      # $t0 = 0
      bne $a0, $t0, RECUR     # $a0 ! = 0 SAUT a RECUR
      add $v0, $zero, 0       # Sinon 0
      j End

  RECUR:
      # CAS DE RECURSIVE

      addi $a0, $a0, -1      # $a0 = n - 1
      jal somme_n
      lw $a0, 0($sp)         # recupere le n d'origine et sauve dans la
      add $v0, $v0, $a0      # v0 =  somme(n-1) + n
      j End

  End:
      lw $ra, 4($sp)
      addi $sp, $sp, 8
      jr $ra
