    .data
# (No data section needed for this case)

    .text
    .globl main

# Main:
main:
    # Save registers
    addi $sp, $sp, -8      # Allocate stack space for two items
    sw $t0, 4($sp)         # Save $t0 (x) on stack
    sw $t1, 0($sp)         # Save $t1 (y) on stack

    # Call Sum
    add $a0, $t0, $zero    # Move x to $a0
    add $a1, $t1, $zero    # Move y to $a1
    jal Sum                 # Jump and link to Sum
    # Result of Sum is now in $v0, move it to $t2
    add $t2, $v0, $zero
    
    # Call Dif 
    # Pass y as first argument, and x as the second
    add $a0, $t1, $zero    # Move y to $a0
    add $a1, $t0, $zero    # Move x to $a1
    jal Dif                 # Jump and link to Dif
    # Result of Dif is now in $v0, move it to $t3 (z)
    add $t3, $v0, $zero

    lw $t1, 0($sp)          # Restore $t1 (y)
    lw $t0, 4($sp)          # Restore $t0 (x)
    addi $sp, $sp, 8        # Deallocate stack space

    # End of Main
    # Return 0 using syscall
    li $v0, 10              # exit system call code
    syscall                 # exit the program

# Procedure Sum (int Sum(int a, int b) { return a + b; })
Sum:
    # Arguments: $a0 = a, $a1 = b
    add $v0, $a0, $a1      # $v0 = a + b (return result)
    jr $ra                  # return to caller

# Procedure Dif (int Dif(int a, int b) { return a - b; })
Dif:
    # Arguments: $a0 = a, $a1 = b
    sub $v0, $a0, $a1      # $v0 = a - b (return result)
    jr $ra                  # return to caller
