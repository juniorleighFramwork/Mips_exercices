# somme_tableau(tab,n)
#   Somme des n premiers element d'un tableau d'entier
#
# SI n == 0 : retourne 0.      cas de basz
# SINON : retourner tab[n-1] + somme_tableau(tab, n-1)
#
# Parametre :
# $a0 = adresse du tableau
# $a1 = n (nombre d'elements à sommer)
#
# Retour :
#   $v0 = somme
#
# Exemple : tab = [1, 5, 2, 7], n = 4
# Attendu : $v0 = 17

.data
  TAB: .word 1, 5, 2, 7

.text:
  main:

      la $a0, TAB             # Adress du tab
      addi $a1, $zero, 4      # n = 4


      jal somme_tableau
      move $a0, $v0
      li $v0, 1
      syscall

      li $v0, 10
      syscall

  somme_tableau:
      # PROLOGUE

      addi $sp, $sp, -8
      sw $ra, 4($sp)
     

      # cas de base
      bne $a1, $zero, RECUR   # tanq n != 0 SAUT a recur
      add $v0, $zero, 0       # sinon 0
      j End

  RECUR:
      # CAS RECURSIVE
      addi $a1, $a1, -1      # n = n-1
      sll $t0, $a1, 2        # $t0 = (n-1) x 4
      add $t1, $t0, $a0      # $t1 = adress memoire
      lw $t2, 0($t1)         # tab[n-1]
      sw $t2, 0($sp)         # sauver dans la pile

      jal somme_tableau      # appel fonction et lire les contenu et revient
      lw $t2, 0($sp)         # load la valeur tab[n-1]
      add $v0, $v0, $t2      # $v0 = somme_tableau(tab, n-1) + tab[n-1]

      j End

  End:

    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
