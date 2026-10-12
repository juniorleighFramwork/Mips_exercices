.data
    # Version itérative :
    # produit = 1
    # i = 0
    # TANT QUE i < n :
    #   produit = produit * tab[i]
    #   i = i + 1
    # retourn produit
    # Le produit de tous les elements d'un tableau
    TAB:  .word 1, 2, 3, 4
.text
  main:

    la $a0, TAB
    addi $a1, $a1, 4            # n = 4
    addi $a2, $a2, 1            # produit = 1
    addi $a3, $a3, 0            # i = i + 1

  LOOP:
    slt $t0, $a3, $a1           # 0 ou 1 : i < n
    bne $t0, $zero, LESS        # if i != 0 saut less
    add $v0, $a2, $zero         # $v0 = produit + 0
    j fin

  LESS:
    sll $t0, $a3, 2             # $t0 : i x 4
    add $t1, $t0, $a0           # adresse memoire du tab
    lw $t2, 0($t1)

    mul $a2, $a2, $t2           # produit = produit * tab[i]
    addi $a3, $a3, 1            # i = i + 1
    j LOOP

fin:
  add $a0, $v0, $zero
  li $v0, 1
  syscall

  li $v0, 10
  syscall
