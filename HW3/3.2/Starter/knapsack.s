.global knapsack
.equ ws,4

.text

knapsack:


prologue:
    .equ num_locals, 0
    .equ num_saved_regs, 0
    push %ebp
    movl %esp, %ebp
    subl $(num_locals + num_saved_regs)* ws, %esp
    
    # ebp + 6:cur_value
    # ebp + 5: capacity
    # ebp + 4: num_items
    # ebp + 3: values
    # ebp + 2: weights
    # ebp + 1 : ret
    # ebp : old ebp

    .equ cur_value, (6* ws) # ebp
    .equ capacity, (5* ws) # ebp
    .equ num_items, (4* ws) # ebp
    .equ values, (3* ws) # ebp
    .equ weights, (2* ws) # ebp
    .equ best_value, (-1*ws) # ebp

    
    movl capacity(%ebp), %eax # eax = capacity
    movl weights(%ebp), %ebx    # ebx = weights
    movl cur_value(%ebp), %ecx  # ecx = cur_value
    movl num_items(%ebp), %edi  # edi = num_items
    movl values(%ebp), %esi     # esi =  values


    # best_value = cur_value;
    movl %ecx, best_value(%ebp)

    # for(i = 0; i < num_items; i++)
    movl $0, num_items(%ebp)
outer_for_start:
        cmpl num_items(%ebp), %edi
        jge outer_for_end

    # (capacity - weights[i] >= 0 ) == capacity - weights[i] < 0
    cmp (%ebx, %edi, ws), %eax # eax = capacity - weights
    jb inner_for_end

    # best_value = max(best_value, knapsack(weights + i + 1, values + i + 1, num_items - i - 1,
                    # capacity - weights[i], cur_value + values[i]));

    # 1) (weights + i + 1
    # 2) (values + i + 1
    # 3) num_items - i - 1
    # 4) capacity - weights[i]
    # 5) cur_value + values[i]

    
    # leal -4(%ebp), %eax just assigns to the %eax register the value of %ebp - 4.
    # It's equivalent to a single sub instruction,
    # except a sub requires the destination to be the same as one of the sources.


# 1) weights + i + 1

        movl weights(%ebp), %ebx    # moves the value of weights from the stack frame into the %ebx register
        leal ws(%ebx, %edi, ws), %ebx # calculates the address of weights + i + 1 and stores it back in %ebx
        push %ebx # pushes the calculated address onto the stack

 # 2) values + i + 1
    
            movl values(%ebp), %ebx    # move value of values from the stack to the %ebx
            leal ws(%ebx, %edi, ws), %ebx # calculate address of values + i + 1 & store in %ebx
            push %ebx # push to stack

# 3) num_items - i - 1
    
                movl num_items(%ebp), %ebx # moves the value of num_items from the stack frame into the %ebx register
                subl %edi, %ebx # subtracts i from num_items and stores the result back in %ebx
                subl $1, %ebx # subtracts 1 from %ebx and stores the result back in %ebx
                push %ebx # push to stack


# 4) capacity - weights[i]
    
                    movl (%ebx, %edi, ws), %ebx # moves the value of weights[i] from the stack frame into the %ebx register
                    subl %ebx, %eax # subtracts weights[i] from capacity and stores the result back in %eax
                    push %eax # push to stack

# 5) cur_value + values[i]
    
                        movl (%esi, %edi, ws), %ebx # moves the value of values[i] from the stack frame into the %ebx register
                        addl %ecx, %ebx # adds cur_value to values[i] and stores the result back in %ebx
                        push %ebx # push to stack

    # call knapsack ( knapsack(weights + i + 1, values + i + 1, num_items - i - 1,
                    # capacity - weights[i], cur_value + values[i]))

        call knapsack # IDK IF THIS IS RIGHT


     # best_value = max(best_value, knapsack(weights + i + 1, values + i + 1, num_items - i - 1,
                    # capacity - weights[i], cur_value + values[i]));

        cmpl %eax, best_value(%ebp) # compares the value of knapsack to best_value
        jle inner_for_end # if knapsack is less than or equal to best_value, jump to inner_for_end
        movl %eax, best_value(%ebp) # moves the value of knapsack into %ebx

     
# eax holds the result of the recursive knapsack call


inner_for_end:
    incl %edi
    jmp inner_for_end

outer_for_end:
    epilogue:
        # restore saved num_saved_regs
        movl %ebp, %esp
        pop %ebp
        ret



