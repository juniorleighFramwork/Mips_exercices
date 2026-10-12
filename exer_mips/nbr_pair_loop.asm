.data
    # VERSION ITERATIVE:
    # compteur = 0
    # i = 0
    # TANT QUE i < n :
    #   SI tab[i] est pair ET tab[i] > x : compteur = compteur + 1
    #   i = i + 1
    # retourne compteur
    # Compte les element sup a x dans le tab
    TAB: .word 2, 8, 1, 4, 10, 3
.text
  main:

    la $a0, TAB             # $a0 = tab
    addi $a1, $zero, 6      # n = 6
    addi $a2, $zero, 0      # compteur = 0
    addi $a3, $zero, 0      # i = 0
    addi $t6, $zero, 3      # x = 3

  LOOP:

    slt $t0, $a3, $a1       # Si i < n : 0 ou 1
    bne $t0, $zero, LESS    # i != 0 saut a LESS
    add $v0, $a2, $zero     # $v0 = compter + 0
    j fin

  LESS:

    sll $t0, $a3, 2         # i x 4 = 4octe
    add $t1, $t0, $a0       # adresse memoire avec la valeur
    lw $t2, 0($t1)          # lire la premier valeur dans le tab[i]

    andi $t3, $t2, 1        # 0 ou 1 : si pair 1 ou 0 impair
    xori $t3, $t3, 1        # inverse : $t3 = 1 inverse a 0, si impaire a 1
    sgt $t4, $t2, $t6       # on verifie si tab[i] > x : 0 ou 1
    and $t5, $t3, $t4       # ce condition veut 1 si les deux sont vrai sinon faux

    beq $t5, $zero, False   # la condition est fausse donc saut
    addi $a2, $a2, 1        # compteur = compteur + 1
    addi $a3, $a3, 1        # on continue $a3 = i + 1

    j LOOP

  False:
    add $a3, $a3, 1
    j LOOP

  fin:
    add $a0, $v0, $zero
    li $v0, 1
    syscall

    li $v0, 10
    syscall
