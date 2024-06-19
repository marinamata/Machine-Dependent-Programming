
_start:

.data
num1:   
        .long 20    # lower part of num1
        .long 152   # upper part of num1
num2:
        .long 40    # lower part of num2
        .long 70    # upper part of num2
        
.text
main:
        movl num1+4, %eax      # Load lower 32 bits of num1 into EAX, storing in regsiters
        addl num2+4, %eax      # add the lower 32 bits, you use the carry flag to add the upper
        movl num1, %edx    # Load upper 32 bits of num1 into EDX, storing in regsiters
        jnc nocarry          # if there is no carry, jump to nocarry
        addl $1, %edx        # add 1 to edx, to add constant value

nocarry:
    addl num2, %edx     # If there is no carry by the addition of the lower 32 bits, add the upper 32 bits of num1 and num2 to EAX

        # addl num2+4, %edx    # add both of the upper values into edx
        
done:
        nop
