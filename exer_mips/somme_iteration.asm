.data

      # Version itérative :
      # somme = 0
      # i = 0
      # TANT QUE i < n :
      #     somme = somme + tab[i]
      #     i = i + 1
      # retourne somme
      tab: .word 3, 8, 1, 9, 4, 2
.text
main:
      # Fonction quie calcule la somme de tous les elements d'un tableau, avec une boucle classique!!
      # initialisation...

      la $a0, tab
      addi $a1, $zero, 6      # n = 5 (compteur)
      addi $a2, $zero, 0      # somme = 0
      addi $a3, $zero, 0     # index = 0

LOOP:

      slt $t0, $a3, $a1        # 0 ou 1 : si i < n
      beq $t0, $zero, FIN_LOOP  # SI i >= n (pas de saut sinon), on sort de la boucle
      sll $t1, $a3, 2           # $t1 = i x 4
      add $t2, $a0, $t1         # $t2 = adess de tab[i]
      lw $t3, 0($t2)            # $t3 = tab[i]
      add $a2, $a2, $t3         # somme = somme + tab[i]
      addi $a3, $a3, 1          # i = i + 1
      j LOOP                    # ON RETOURNE VER LA BOUCLE

FIN_LOOP:
      add $v0, $a2, $zero       # on met le resultat dans $v0
      j fin

fin:
      add $a0, $v0, $zero

      li $v0, 1
      syscall

      li $v0, 10
      syscall
