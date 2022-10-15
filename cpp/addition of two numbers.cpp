#include <iostream>

using namespace std; // This is standard library

int main()
{
    /* Get two inputs and output the sum */

    int no1, no2, ans;

    cout << "Enter first number "; cin >> no1;
    cout << "Enter second number "; cin >> no2;
    ans = no1 + no2;
    cout << "The answer is " << ans<<endl;
    return 0;
}
