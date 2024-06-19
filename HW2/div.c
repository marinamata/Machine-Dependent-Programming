#include <stdio.h>
#include <stdlib.h>
 
  void longDivision(unsigned int dividend, unsigned int divisor) {
     unsigned int quotient = 0;
     unsigned int remainder = 0;
    // int count = 0;
     //then divide and shift right every time 
     unsigned int temp_dividend = 0;
     temp_dividend = temp_dividend << 1;
     for(unsigned int i = 31; i != -1; --i) {
      temp_dividend = temp_dividend << 1;
     
      if ((dividend >> i) & 1) { // checking if bit at i is set
        temp_dividend |= 1;
      }
      
      if (temp_dividend >= divisor) {
        temp_dividend-= divisor; // actually dividing
        if (quotient != (1<<i)) {
          quotient |= 1<<i;
          } // if bit is set update quotient
      }
      //temp_dividend = temp_dividend << 1; // updating temp dividend

     }
     
     remainder = temp_dividend;

     //printing values
     printf("%u / %u = %u R %u\n", dividend, divisor, quotient, remainder);
  }

  int main(int argc, char **argv){
  unsigned int dividend = strtoul((argv[1]), NULL, 0);
  unsigned int divisor = strtoul(argv[2], NULL, 0);

  longDivision(dividend, divisor);  
    return 0;
}

  //STEPS

  // start at the beginning of the dividend
  //  check if divisor goes into position at i
  //  right shift by one until divisor goes into number
  //  then subtract (with 0-1 = 1)
  //  left shift one to bring down new number to divide by
  //  do until no decimal places left
  //  take leftover number as remainder and number it went into as quotient
