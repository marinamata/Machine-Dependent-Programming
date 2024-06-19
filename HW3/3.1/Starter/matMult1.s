
/*
CODE TO TRANSLATE:

int** matMult(int **a, int num_rows_a, int num_cols_a, int** b, int num_rows_b, int num_cols_b) {
    // Create a new matrix to store the result
    int** result = (int**)malloc(num_rows_a * sizeof(int*));
    for (int i = 0; i < num_rows_a; i++) {
        result[i] = (int*)malloc(num_cols_b * sizeof(int));
    }

    // Perform matrix multiplication
    for (int i = 0; i < num_rows_a; i++) {
        for (int j = 0; j < num_cols_b; j++) {
            int sum = 0;
            for (int k = 0; k < num_cols_a; k++) {
                sum += a[i][k] * b[k][j];
            }
            result[i][j] = sum;
        }
    }
    
    return result;
}
*/

global_start.

.equ ws, 4          # word size of 4 bc we are doing 32 bits

.text

_start:

main: 

matmult:

# 1st thing to write is the prologue
    .equ num_locals, 3 # result, row, col
    .equ num_saved_registers, 1
    push %ebp
    movl %esp, %ebp
    subl $(num+locals + num_saved_registers)* ws, %esp # make space for locals and saved registers

    # stack
    # arguments first placed on stack( last to first):
    # ebp +7: num_cols_b
    # ebp +6 : num_rows_b
    # ebp + 5: b
    # ebp + 4: num_cols_a
    # ebp +3 : num_rows_a
    # ebp + 2: a
    # ebp +1 : return address
    # ebp: save ebp
    # ebp -1: result
    # ebp - 2: sum
    # ebp -3=: k
    # ebp - 4 : j
    # ebp - 5: i
   

    # this is foryourself to keep track of locations

    .equ a, (2 * ws)  # (%ebp)
    .equ B, (5 * ws) # (%ebp)
    .equ num_rows_a, (3 * ws) # (%ebp)
    .equ num_cols_a, (4 * ws) # (%ebp)
    .equ result, (-1 * ws) # (%ebp)
    .equ num_cols_b, (7 * ws) # (%ebp)
    .equ old_esi, (-4 * ws) # %ebp


    # save called saved registers
    movl %esi, old_esi(%ebp)
    movl %edi, old_esi(%ebp)
    
    
    prologue_end_multp:

    # int** result = (int**)malloc(num_rows_a * sizeof(int*));
    movl num_rows_a(%ebp), %eax   # eax = num_rows_a
     # multiply, instead of imull, we r gonna shift it to the left by 2 which is the same thing as multiplying by 4
     shll $2, %eax # eax = num_rows * sizeof(int*)
     push %eax # push eax onto the stack
     call malloc
     addl $1*ws, %esp # remove the argument to malloc from the stack

    # now we need to put the value into result
    movl %eax, result(%ebp) # result = eax


    # ecx will be i
    # edx will be j
    # esi will be k

    
    # for(int i = 0; i < num_rows_a; i++){
   movl $0, row(%ecx) # set i = 0, row = 0
    outer_for_start_multp:
        # i <numRows == i -num_rows < 0
        # negation should be like : i - num_rows >= 0
        cmpl num_rows_a(%ebp), %ecx # row - num_rows
        jge outer_for_end_multp # if if row - num_rows >= 0, then jump to outer_for_end

        movl $0, %edx # set j = 0, col = 0
        #  for (int j = 0; j < num_cols_b; j++) {
            inner_for_start_multp:
            cmpl num_cols_b(%ebp), %edx # col - num_cols
            jge inner_for_end_multp # if j - numCols >= 0 then jump to inner_for_end
            
            # int sum = 0;
            movl $0, %eax # set sum = 0


            movl $0, %esi # set k = 0, col =0

        kloop_start_multp:
        # for (int k = 0; k < num_cols_a; k++) {
            cmpl num_cols_a(%ebp), %esi # col - num_cols_a
            jge kloop_end_multp # if k - numCols >= 0 then jump to


            # sum += a[i][k] * b[k][j];
            movl A(,%ecx,ws), %ebx   # ebx = a[i][k]
            movl B(,%esi,ws), %edx   # edx = b[k][j]

            # Multiply a[i][k] and b[k][j] and accumulate the result
            imull %ebx, %edx        # multiply a[i][k] and b[k][j] and store the result in edx

            # Accumulate the result in sum (assuming sum is in eax)
            addl %edx, %eax         # add the product to the sum


            incl %esi # k++
            jmp kloop_start_multp   # repeat the inner loop

            kloop_end_multp: # end the loop
            movl %eax, result(,%ecx,ws,%edx) # # store the sum in result[i][j]

            incl %edx # j++
            jmp inner_for_start_multp

    inner_for_end_multp:
        # code
        incl %ecx # i++
        jmp outer_for_start_multp # jump to do next iteration


    outer_for_end_multp:

    # return result
    movl result(%ebp), %eax

    epilogue_multp:
         movl old_esi(%ebp), %esi
        movl old_edi(%ebp), %edi
        movl %ebp, %esp
        pop %ebp
        ret


    done:
        nop
