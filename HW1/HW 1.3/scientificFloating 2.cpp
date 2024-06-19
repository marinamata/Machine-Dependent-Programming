#include<string>
#include<cmath>
#include<iostream>
using namespace std;


int main(){
  
   float initialFloat;
   cout<<"Please enter a float: "<<endl;
  
   cin>>initialFloat;


   unsigned int float_int = *((unsigned int*) &initialFloat);  //cast the float using thingy in instructions


//extract the sign, exponent, and fraction bits using bitwise operator
   unsigned int sign;
   unsigned int exponent;
   unsigned int mantissa;


   sign = float_int >> 31; //shift right 31 times to get the sign
   exponent = float_int << 1; //shift left 1 time to get the exponent
   exponent = exponent >> 24; //shift right 24 times to get the exponent


   //(i guess the fraction part of a float is called mantissa)
   mantissa = float_int << 9; //shift left 9 times to get the mantissa
   mantissa = mantissa >> 9; //shift right 9 times to get the mantissa


//now that we have the sign exponent and fraction bits of float we make the scientific base 2


   if(sign == 1){
       cout<<"-";
   }
   cout<<"1.";
   for(int i = 22; i >= 0; i--){
       if((mantissa >> i) & 1){
           cout<<"1";
       }
       else if(i==0){
              ;
       }
       else{ 
           cout<<"0";
       }
   }
   
   
   cout<<"E";
   cout<<exponent - 127<<endl;
}