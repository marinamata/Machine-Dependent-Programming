#include <algorithm>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
using namespace std;

vector<int> matrix_mult(int n, vector<int> arr1, vector<int> arr2) {
    vector<int> result; 

    //Uses formula given in lecture to translate a 2d array index to single array
    //I*N + J

    for (int i = 1; i < n+1 ; i++) {
        for (int j = 1; j < n+1; j++) {
            while (i>j) {j++;} // if i>j than it should be a 0 AKA not shown on the result
            for (int k = 0 ; k < n+1; k++) {
                result[k] += arr1[i*n +k] * arr2[k*n+j]; // only calculates upper triangular quantities
            }
        }
    }
    return result;
}

int main(int argc, char* argv[]) {
    //take in input files and put into 2 arrays
    ifstream file1;
    ifstream file2;
    vector <int> v1;
    vector <int> v2;
    int s;
   // int q = -1; // counts variables in file, negative one to account for dimension in filw
    file1.open(argv[1]);
    file1.open(argv[2]);

    //getting first file into array
    while (file1 >> s) {
        v1.push_back(s);
     //   q++;
    }
    reverse(v1.begin(),v1.end()); // reversing so its in right order cuz of push back used 
    int n = v1[0]; // getting the dimension

    while (file2 >> s) { // filling second vector
        v2.push_back(s);
    }
    
    reverse(v2.begin(),v2.end()); // reversing so its in right order cuz of push back used 
    vector<int> result = matrix_mult(n, v1, v2); //calling function

    for(vector<int>:: iterator i = result.begin(); i!= result.end(); ++i) { // printing result
        cout << *i << " ";
    }

    return 0;

}
