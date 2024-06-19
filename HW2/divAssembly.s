_start:

.data
remainder:
        .long 0
quotient:
        .long 0
divisor:
        .long 2
dividend:
        .long 10
temp_dividend:
        .long 0
index:
        .byte 3
temp_quotient:
        .long 1

.text
.globl _start

main:
    mov dividend, %eax
    mov index, %cl
    movl divisor, %edx
    movl temp_dividend, %ebx
    movl quotient, %edi
    mov temp_quotient, %esi
FOR_EACH_BIT:
    cmp $0, %cl
    jl END_FOR_EACH_BIT
    shl $1, %ebx                            # line 12
    shr %cl, %eax                           # line 14
    and $1, %eax                            # line 15
    cmp $1, %eax                            # line 15
    je IF_I_BIT_IS_ONE                      # line 16
    jne END_IF_I_BIT_IS_ONE
IF_I_BIT_IS_ONE:
    or $1, %ebx                             # line 15
END_IF_I_BIT_IS_ONE:
    cmp %edx, %ebx                          # line 18
    jge IF_DIVISOR_GOES_IN_TDIVIDEND
    jmp UPDATE_FOR_EACH_BIT                 # begin nested loop
IF_DIVISOR_GOES_IN_TDIVIDEND:
    sub %edx, %ebx                           # line 19
    shl %cl, %esi                            # line 20
    cmp %edi, %esi                          # line 20
    jne IF_Q_NOT_TEMPQ
    jmp UPDATE_FOR_EACH_BIT
IF_Q_NOT_TEMPQ:
    or %esi, %edi
    mov $1, %esi
UPDATE_FOR_EACH_BIT:
    dec %cl
    mov dividend, %eax
    jmp FOR_EACH_BIT
END_FOR_EACH_BIT:
    xor %eax, %eax      # clear register
    xor %edx, %edx      # clear register
    mov %edi, %eax
    mov %ebx, %edx
done:
    nop

