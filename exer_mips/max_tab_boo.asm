.data
    tab: .word 3, 8, 1, 11, 4, 15
.text
main:
      # Version itérative :
      # max = tab[0]
      # i = 1
      # TANT QUE i < n :
      #     SI tab[i] > max : max = tab[i]
      #     i = i + 1
      # retourne max

      # Trouve l'element max dans un tableau et sauve le

      la $a0, tab
      addi $a1, $zero, 6      # n = 6
      addi $a2, $zero, 1      # i = 1
      lw $a3, 0($a0)          # max = tab[Ø]



LOOP:
    # PROLOGUE
    slt $t0, $a2, $a1
    bne $t0, $zero, max       # IF i != 0 SAUT
    add $v0, $a3, $zero
    j END

max:
    sll $t0, $a2, 2           # i x 4
    add $t1, $t0, $a0         # tab[i]
    lw $t2, 0($t1)            # Lire la premiere valeur de tab[Ø]
    sgt $t3, $t2, $a3         # Si tab[i] > max : 1 sinon 0
    beq $t3, $zero, is_less   # $t3 tab[i] == 0 is less
    add $a3, $zero, $t2         # max = tab[i]
    j is_less

is_less:
    add $a2, $a2, 1
    j LOOP

END:
    add $a0, $v0, $zero
    li $v0, 1
    syscall

    li $v0, 10
    syscall
