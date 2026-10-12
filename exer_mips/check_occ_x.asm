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
    # PROLOGUE

    slt $t0, $a3, $a1        # i < n : 0 ou 1
    beq $t0, $zero, END_LOOP # if i != 0 End loop
