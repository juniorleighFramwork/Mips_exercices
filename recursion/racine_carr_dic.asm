# racine_carree_dichotomique(n, bas, haut) :
#   SI bas > haut : retourner -1                          (n n'est pas un carré parfait dans cette plage)
#   m = (bas + haut) / 2
#   SI m*m == n : retourner m
#   SINON SI m*m > n : retourner racine_carree_dichotomique(n, bas, m-1)
#   SINON : retourner racine_carree_dichotomique(n, m+1, haut)
#
# Paramètres :
#   $a0 = n (le nombre dont on cherche la racine carrée)
#   $a1 = bas
#   $a2 = haut
# Retour :
#   $v0 = racine carrée entière de n, ou -1 si n n'est pas un carré parfait dans [bas,haut]
#
# Exemple : n=49, bas=0, haut=10
# Attendu : $v0 = 7
.data

.text
  main:

    addi $a0, $zero, 49                 # n = 49
    addi $a1, $zero, 0                  # bas = 0
    addi $a2, $zero, 10                 # haut = 10

    jal racine_carree_dichotomique
    add $a0, $v0, $zero

    li $v0, 1
    syscall

    li $v0, 10
    syscall

  racine_carree_dichotomique:
  #PROLOGUE

    addi $sp, $sp, -8                   # Reserve de la place dans la pile
    sw $ra, 4($sp)                       # La valeur de retour
    #sw $a1, 4($sp)                      # la valeur de l'argument


    # CAS DE BASE

    sgt $s0, $a1, $a2                   # 1 si true : bas > haut
    bne $s0, $zero, NOT_carre           # Si $s0 != go to not_carré
    addi $t0, $zero, 2                  # $t0 = 2
    add $t1, $a1, $a2                    # m = bas + haut
    div $t1, $t0                        # m / 2
    mflo $s2                            # = m

    mul $s3, $s2, $s2                   # $s3 = m*m
    beq $s3, $a0, EQUAL                 # iF m*m == n SAUT A EQUAL
    sgt $t3, $s3, $a0                   # 1 si great : $s3 > n
    bne $t3, $zero, GREAT               # if $t3 != 0 SAUT great
    add $a1, $s2, 1                     # bas = m+1
    jal racine_carree_dichotomique
    j END


  GREAT:
    add $a2, $s2, -1                    # haut = m-1
    jal racine_carree_dichotomique
    j END

  EQUAL:
    add $v0, $zero, $s2                 # Retourn m
    j END
  NOT_carre:
    add $v0, $zero, -1                  # n n'est pas carré parfait dans cette plage
    j END

END:
  lw $ra, 4($sp)
  addi $sp, $sp, 8
  jr $ra
