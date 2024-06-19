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

// to take input with letters take it as a string and parse through for letters and set the position with the letters to the corresponding numbers
    // for (int i = 0 ; i < number.length() ; i++) {
    //     if (!isdigit(number[i])) {
    //         // converting to number
    //         int holder = int(toupper(number[i])-55);
    //         number.replace(i,2,to_string(holder));
    //     }
    // }
    // cout << number << endl;
    // int new_number = stoi(number);

/*convert from the given base to base 10;
1. divide the base 10 value by the new base we want
2. keep dividing the new quotient by the new base until the quotient is 0
3. write the remainders from bottom to top, left to right to get your new answer.
*/

    int decimal=0;  //the decimal value of the number
    int power= 1;   //the power of the base
    int x= stoi(number);
    int index = number.length();
    // cout << index;
    //  while(index>0){    //while the number is greater than 0
    //      decimal += (x%10)*pow(baseInput,power);    //add the last digit times the base to the power of the digit's position
    //      cout << decimal<< endl;
    //      x /= 10;   //divide the number by 10 to get the next digit
    //      power++;    //increment the power
    //     index--;
    //  }

// cout << number;
    for (int i = number.length()-2 ; i >= 0 ; i--){
      //  cout << number[i] << endl;
        if (!isdigit(number[i])){ // if current char is not a digit
            decimal += ((int(toupper(number[i])-55)) % 10) *power;
            cout << decimal << endl;
        } else {
            int f = number[i];
            decimal += f*power;
            cout << decimal << endl;
        }
        power=power*baseInput;
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
    final_num += *i;  // putting remainders into a string
} 

cout << final_num << endl;

}








