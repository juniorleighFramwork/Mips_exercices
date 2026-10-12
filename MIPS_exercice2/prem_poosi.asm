# trouve_premier_positif(tab, bas, haut)
#  Hypothèse : tab est trié, et contient d'abord des negatifs puis des positifs/zeros
#  (ex: {-9, -4, 0, 3, 7, 12})
#
#  SI bas == haut : retourner bas    (cas de base)
#  m = (bas + haut) / 2
#  SI tab[m] >= 0 : retourner trouve_premier_positif(tab, bas, m)
#  SINON : retourner trouve_premier_positif(tab, m+1, haut)
#
# Parametres :
#   $a0 = adresse de base du tableau
#   $a1 = bas (indice de début, commence à 0)
#   $a2 = haut (indice de fin, commence à n-1)
# Retour :
#   $v0 = indice du premier élément >= 0
#
# Example : tab = {-9, -4, -2, 0, 3, 7, 12}, bas = 0, haut = 6
# Attendu : $v0 = 3

.data
    TAB: .word -9, -4, -2, 0, 3, 7, 12
.text
  main:

      la $a0, TAB
      addi $a1, $zero, 0              # indice debut : bas = 0
      addi $a2, $zero, 6              # indice fin : haut = 6

      jal PREMIERE_POSITIF
      add $a0, $v0, $zero
      li $v0, 1
      syscall
      li $v0, 10
      syscall

PREMIERE_POSITIF:
      # PROLOGUE

      addi $sp, $sp, -12               # RESERVE DE LA PLACE DANS LA PILE
      sw $ra, 8($sp)                   # SAUVER LA VALEUR DE RETOUR
      sw $a1, 4($sp)                   # Sauver la valeur bas

      # CAS DE BASE
      # SI BAS == HAUT : RETOURNE BAS
      bne $a1, $a2, RECUR             # SI bas != Haut Saut a recur
      add $v0, $zero, $a1             # Sinon Retourne BAS
      j END

RECUR:
      # CAS RECURSIF
      #  m = (bas + haut) / 2
      #  SI tab[m] >= 0 : retourner trouve_premier_positif(tab, bas, m)
      #  SINON : retourner trouve_premier_positif(tab, m+1, haut)

      add $t0, $a1, $a2                 # $t0 = bas + haut
      addi $t1, $zero, 2                # $t1 = 2
      div $t2, $t0, $t1                 # m = (bas + haut) / 2

      #  SI tab[m] >= 0 : retourner trouve_premier_positif(tab, bas, m)
      sll $t3, $t2, 2                   # m x 4 = $t3 (octet)
      add $t4, $t3, $a0                 # tab[m] : adress memory
      lw $t5, 0($t4)                    # Lire la valeur tab[m]
      sw $t5, 0($sp)                    # Sauver la valeur dans la pile

      add $a2, $a2, -1                   # haut = haut - 1
      jal PREMIERE_POSITIF
      lw $t6, 0($sp)                    # Lire la valeur tab[m]
      lw $t7, 4($sp)                    # Mise a jour la derniere valeur

      addi $s0, $zero, 0                # 0 DEFAULT
      sgt $s1, $t6, $s0                 # 0 ou 1: si tab[m] > 0 (1 sinon 0)
      beq $t6, $s1, POSITIF           # if tab[m] >= 0 Positif
      j END

POSITIF:
      add $v0, $t7, $zero
      j END

END:

    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra
