# Version iteration
# i = 0
# TANT QUE chaine1[i] != '\0' ET chaine2[i] != '\0'
# SI chaine1[i]!= chaine2[i] : retourne 0 (differentes)
# i = i + 1
# SI chaine1[i] != chaine2[i] : retourne 0 ( une des deux continue, l'autre finit
# retourne 1 (identiques

# Compare deux chaines differentes pour voir si elle sont identiques
.data
CHAINE1: .asciiz "chien"
CHAINE2: .asciiz "chienne"
.text
main:
la $a0, CHAINE1 # $a0 = CHAINE1
la $a1, CHAINE2 # $a1 = CHAINE2
addi $a2, $zero, 0 # i = 0

LOOP:
add $t0, $a0, $a2 # $t0 = chaine1 + i = adress memory
lb $t1, 0($t0) # $t1 = chaine1[i]

add $t2, $a1, $a2 # $t2 = chaine2 + i = adress memory
lb $t3, 0($t2) # $t3 = chaine2[i]

bne $t1, $zero, NOT_EQUAL # chaine1[i] != 0 saute Not_equal
add $v0, $zero, 1 # retourne 1. (identique)
j END

NOT_EQUAL:
addi $a2, $a2, 1     # i = i + 1
beq $t1, $t3, it_equal # chaine1[i] == chaine2[i] SAUT it_equal
add $v0, $zero, 0     # pas identique

it_equal:
add $v0, $zero, 1 #identique
j CHAINE_2

CHAINE_2:
lb $t3, 4($t3)
bne $t3, $zero, not_equal_2 # chaine1[i] != 0 saut not_esual_2
add $v0, $zero, 1 # if identique
j LOOP
not_equal_2:
addi $a2, $a2, 1
beq $t3, $t1, EQUAL
add $v0, $zero, 0
j LOOP

EQUAL:
add $v0, $zero, 1
j END
END:
add $a0, $v0, $zero
li $v0, 1
syscall
li $v0, 10
syscall
