.data
    TAB: .word -3, 5, -1, 8, -7, 2
.text
    # Version itérative :
    # compteur = 0
    # i = 0
    # TANT QUE i < n :
    #     SI tab[i] < 0 : compteur = compteur + 1
    #     i = i + 1
    # retourne compteur
main:
    # Fonction qui comptz les nombre d'element negatif dans un tableau.
    la $a0, TAB         # assign TAB in register($a0)
    addi $a1, $zero, 6  # n = 5
    add $a2, $zero, 0   # compt = 0
    add $a3, $zero, 0   # i = 0

LOOP_NEG:
    # PROLOGUE

      slt $t0, $a3, $a1          # if i < n
      bne $t0, $zero, IT_LESS    # if $t0 != 0
      add $v0, $a2, $zero
      j END

IT_LESS:
      sll $t0, $a3, 2            # i x 4
      add $t1, $t0, $a0          # $t1 = tab[i]
      lw $t2, 0($t1)

      slt $t3, $t2, $zero        # si tab[i] < 0 : 0 ou 1
      beq $t3, $zero, NON_NEG   # if tab[i] >= 0 End
      addi $a2, $a2, 1         # compteur = compter + 1
      j NON_NEG               # Jump to Non_neg

NON_NEG:
      addi $a3, $a3, 1        # $a3, = 1 + 1
      j LOOP_NEG

END:
      add $a0, $v0, $zero
      li $v0, 1
      syscall
      li $v0, 10
      syscall
