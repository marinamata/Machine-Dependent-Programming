#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <ctype.h>

//using namespace std;

int main(int argc, char *argv[]){   //convert input into integer (use atoi)(frid)
    //convert input into integer (use atoi)(frid)
    for(int i = 0; i < argc; i++)   //convert input into integer (use atoi)(frid)
    {
        unsigned int value; //convert input into integer (use atoi)(frid)
        std::stringstream(argv[i]) >> value;    

        bool isUpper = value &(1<<26);  //check if the letter is uppercase //WORKS

        unsigned int letterBits = value & ((1<<26)-1);  //get the letter bits

        char letter = 0;    //the letter to be printed
        char alphabet[26] = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
        for(int bit=0;bit<26;bit++) //convert the letter bits to a lettern
        {
            if(letterBits & (1<<bit))   //if the bit is set
            {   
                letter = alphabet[bit];  //set the corresponding bit in the letter
            }
        }
        if(isUpper)   //if the letter is uppercase
        {
            letter = toupper(letter);   //convert the letter to uppercase   
        }

        std::cout << letter; //print the letter
    }
    std::cout << std::endl;   //print a new line
    return 0;   //return 0
}
    
    /*#include <string>

using namespace std;

string decode_letter(int encoded_letter) {
    int capital_bit = encoded_letter >> 31; // extract capital bit
    int letter_bits = encoded_letter & 0x7FFFFFFF; // extract letter bits
    string result;

    for (int i = 0; i < 26; ++i) {
        if ((letter_bits >> i) & 1) {
            result += 'a' + i;
        }
    }

    if (capital_bit) {
        for (char& c : result) {
            c = toupper(c); // convert result string to uppercase
        }
    }

    return result;
}
    */