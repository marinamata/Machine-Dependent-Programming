.global get_combs
.equ ws,4

/*int** get_combs(int* items, int k, int len)
{
  int ctr = 0, ret_array_size;

  ret_array_size = num_combs(len, k);  

  int** ret_array = malloc(ret_array_size * 4);
  int* temp = malloc(ret_array_size * 4);

  for(int i = 0; i < ret_array_size; i++)
  {
      ret_array[i] = malloc(k * 4);
  }

  permute(items, 0, len - 1, ret_array, k);

  return ret_array;
}
*/


recursive_comb:
    prologue:
    .equ num_locals, 0
    .equ num_saved_regs, 0
    push %ebp
    movl %esp, %ebp
    subl $(num_locals + num_saved_regs)* ws, %esp

    # arguments
	.equ items,(2*wordsize) 
	.equ k,(3*wordsize) #(%ebp)
	.equ len, (4*wordsize) #(%ebp)

    




    epilogue:
		movl %ebp, %esp
		pop %ebp
		ret