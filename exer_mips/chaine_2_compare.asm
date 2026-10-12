.data
# Version iteration
# i = 0
# TANT QUE chaine1[i] != '\0' ET chaine2[i] != '\0'
# SI chaine1[i]!= chaine2[i] : retourne 0 (differentes)
# i = i + 1
# SI chaine1[i] != chaine2[i] : retourne 0 ( une des deux continue, l'autre finit
# retourne 1 (identiques

# Compare deux chaines differentes pour voir si elle sont identiques

CHAINE1:   .asciiz "chienZ"
CHAINE2:   .asciiz "chat"
.text
  main:

      la $a0, CHAINE1         # $a0 = CHAINE1
      la $a1, CHAINE2         # $a1 = CHAINE2

      addi $a2, $zero, 0      # i = 0
LOOP:

      add $t0, $a0, $a2       # adress memory by byte
      lb $t1, 0($t0)          # $t1 = chaine1[i]

      add $t2, $a1, $a2       # adress memory by byte
      lb $t3, 0($t2)          # chaine2[i]

      # TANT QUE chaine1[i] != '\0' ET chaine2[i] != '\0'
      beq $t1, $zero, CHECK_END   # IF chaine1[i] == 0 SAUT
      beq $t3, $zero, CHECK_END   # IF chaine2[i] == 0 SAUT

      bne $t1, $t3, EQUAL_ZERO    # IF $t1 != $t3 SAUT
      add $a2, $a2, 1             # i = i + 1
      j LOOP

CHECK_END:
      bne $t1, $t3, EQUAL_ZERO     # IF chaine[i] != chaine2[i] SAUT
      add $v0, $zero, 1           # identique
      j END

EQUAL_ZERO:
      add $v0, $zero, 0           # NOT IDENTIQUE
      j END

END:

    add $a0, $v0, $zero           # Save the last value
    li $v0, 1                     # print the value
    syscall
    li $v0, 10                    # System END
    syscall
