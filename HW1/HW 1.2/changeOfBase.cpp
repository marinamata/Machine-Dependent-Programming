#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <vector>
#include <ctype.h>
#include <cmath>

using namespace std;


string remainder_to_string(int remainder){ // converting necessary numbers to integers
    char alphabet [] = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
    if (remainder >= 10) {
        string s ="";
        s += alphabet[remainder - 10];
        return s;
    }
    return to_string(remainder);
}

int character_to_int(char c){ // converting characters to integers
    char alphabet [] = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',
        'P','Q','R','S','T','U','V','W','X','Y','Z'};
    char b = toupper(c);
    for (int i = 0; i < 26; i++){
        if (b == alphabet[i]){
            return i+10;
        }
    }
    return c - '0';
}
char int_to_character(int i){ // converting integers to characters
    if(i>=0 && i<=9){
        return i + '0';
    }
    else{
        return (i-10) + 'A';
    }
}

int main(){
    
    int baseInput;
    std::cout << " Please enter the number's base: ";
    cin >> baseInput;
    string number;
    std::cout << " Please enter the number: ";
    cin >> number;
    int newBase;
    std::cout << " Please enter the new base: ";
    cin >> newBase;
    
    cout <<" "<<number<< " base " <<baseInput<<" is ";
    
    /*convert from the given base to base 10;
     1. divide the base 10 value by the new base we want
     2. keep dividing the new quotient by the new base until the quotient is 0
     3. write the remainders from bottom to top, left to right to get your new answer.
     */
    
<<<<<<< HEAD
    int decimal=0;  //the decimal value of the number
=======
    unsigned int decimal=0;  //the decimal value of the number
>>>>>>> e798cba5c578f18d80acb77e73c1490926536e8e
    int power= 0;   //the power of the base
    for(int i = number.size()-1;i >= 0; i--){    //for each digit in the number
        decimal += character_to_int(number[i])*pow(baseInput,power);    //add the digit times the base to the power of the digit's position
        power++;    //increment the power
    }
    
    
    /*now we need to convert the number from base 10 to the new base prompted
     1. Divide the decimal number by the new base.
     2. Keep dividing the quotient by the new base until the quotient becomes zero.
     3. Write down the remainders in reverse order.
     */
    
    int new_base = 0;   //the new base value of the number
    int order = 0;  //the order of the new base
    
    string final_num = ""; // string will hold final number
    vector <string> final_ints; // vector will hold remainders necessary for final number
    
    while(decimal != 0){
        new_base = decimal % newBase;   //keep dividing thee quotoent by new base
        decimal = decimal / newBase;    //divide the decimal by the new base
        final_ints.push_back(remainder_to_string(new_base));
        order++;    //increment the order
    }
    
    for (vector<string>::reverse_iterator i = final_ints.rbegin();  i != final_ints.rend(); ++i ) {
<<<<<<< HEAD
       // if (isdigit(*i)) {
       //      a = int_to_character(stoi(*i));
       // } else {
             
       // }
=======
>>>>>>> e798cba5c578f18d80acb77e73c1490926536e8e
        final_num += *i;  // putting remainders into a string
    }
    
    cout<<final_num <<" base "<<newBase<< endl;
    
<<<<<<< HEAD
}
=======
}







>>>>>>> e798cba5c578f18d80acb77e73c1490926536e8e
