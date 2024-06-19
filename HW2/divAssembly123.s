_start:

.data

remainder:
        .long 0

quotient:
        .long 0

divisor:
        .long 0

dividend:
        .long 0

temp_dividend:
        .long 0

index:
        .long 31

quotient_comp:
        .long 1

.text

.globl _start

        # Load the dividend into %eax. TREAT EAX LIKE DIVIDEND
        mov dividend, %eax

        #load quotient quotient_comp
        mov quotient_comp, %esi

        # Load the divisor . TREAT ECX LIKE DIVISOR VAR
        mov divisor, %edx

        # load temp dividend into register
        mov %eax, %ebx # changing this from(mov temp_dividend, %ebx) to current one

        # load i into register
        mov index, %ecx

        # temp_dividend = temp_dividend << 1;

        shl $1, %eax # line 12 , abx changed to eax

        mov quotient, %edi  #line 12, changed this from mov quotient, %edi to mov quotient_comp, %edi

        jmp for_start   #begin nested loop


for_start:
        mov quotient_comp,%esi #resetting to 1, for the loop
        # Check if i is less than 0. then end
        cmpl $0, %ecx
        jle for_end

        # decrement i
        dec %ecx

        # left shifting temp dividend
        shl $1, %ebx;

        # checking if (dividend >> i) is set
        shr %cl, %eax   # changed it from eax to ebx, see if it works and also changing cl to ecx, line 14
        and $1, %eax    # line 14
        cmpl $1, %ebx   # line 14
        jz if_execute   # make jump to line 15, else

        # temp_dividend |= 1;  # putting in other latbel
        # or $1, %ebx

back_one:
        # shift dividend back # loop starts at line 17
        shl %cl, %eax

        # starting line 18 if statement
        cmp %ebx, %edx
        jge greater_than_or_equal

        # done jumpign with the nested ifs. back to for.
        jmp for_start
for_end:
        # setting quotient and remainder to respective registers
        movl %edi, %eax
        movl %ebx, %edx
        jmp done

if_execute:
        #temp_dividend |= 1;  # putting in other latbel
         or $1, %ebx    # line 15
         jmp back_one

greater_than_or_equal: # subtracts and stores value in temp dividend
        sub %ebx, %edx
        shl %cl, %esi
        cmp %edi, %esi # comparing quotient with result of shift
        jne not_equal

        # ADDED THESE RN:
        mov %edi, %eax  # Move quotient to eax
        shl %cl, %eax  # Shift left i times
        cmp %eax, %esi  # Compare quotient with shifted value
        jne not_equal  # Jump if not equal

        jmp for_start

not_equal: #for line 21
        or %esi, %edi   # changed the order of these
        jmp for_start


done:
        nop
