.data
    # Version iterative
    # somme = 0
    # i = 0
    # TANT QUE i < n :
    #   somme = somme + tab[i]
    # i = i + 1
    # moyenne = somme / n
    # retourne moyenne

    # La moyenne d'un tab entier

    TAB: .word 4, 8, 1, 9, 4, 2
.text
  main:

    la $a0, TAB
    addi $a1, $zero, 6        # n = 6
    addi $a2, $zero, 0        # somme = 0
    addi $a3, $zero, 0        # i = 0
    addi $t6, $zero, 0        # moyenne = 0

  LOOP:

    slt $t0, $a3, $a1         # i < n : 0 ou 1
    bne $t0, $zero, LESS      # if i != 0 saut a less
    div $t6, $a2, $a1         # moyenne = somme / n
    add $v0, $t6, $zero
    j fin

  LESS:
    sll $t1, $a3, 2
    add $t2, $t1, $a0         # adresse memoire
    lw $t3, 0($t2)

    add $a2, $a2, $t3
    addi $a3, $a3, 1
    j LOOP

  fin:
    add $a0, $v0, $zero
    li $v0, 1
    syscall
    li $v0, 10
    syscall
