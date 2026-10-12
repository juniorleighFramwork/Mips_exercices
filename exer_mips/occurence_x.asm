.data
    # Version Iteration :
    # compteur = 0
    # i = 0
    # TANT QUE i < n :
    #     Si tab[i] == x : compteur = compteur + 1
    # i = i + 1
    # retourne compteur

    TAB: .word 4, 8, 1, 9, 4, 2
.text
  main:

    # PROLOGUE
    la $a0, TAB
    addi $a1, $zero, 6       # n = 6
    addi $a2, $zero, 0       # compteur = 0
    addi $a3, $zero, 0       # i = 0
    addi $t6, $zero, 4       # x = 4

  LOOP:

    slt $t0, $a3, $a1        # i < n : 0 ou 1 (if yes = 1 or if No = 0) save in the registre $t0
    beq $t0, $zero, END_LOOP # I >= N
    sll $t1, $a3, 2          # i x 4
    add $t2, $t1, $a0
    lw $t3, 0($t2)

    beq $t3, $t6, EQUAL       # if $t3 == x SAUT A EQUAL
    add $a3, $a3, 1          # i = i + 1
    j LOOP                   # sinon jump to loop

  EQUAL:
    add $a2, $a2, 1          # compteur = compteur + 1
    addi $a3, $a3, 1         # i = i + 1
    j LOOP

  END_LOOP:
  add $v0, $a2, $zero
  j fin

fin:
      add $a0, $v0, $zero

      li $v0, 1
      syscall

      li $v0, 10
      syscall
