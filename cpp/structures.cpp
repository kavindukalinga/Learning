#include <iostream>

using namespace std;

struct rectangle{
  int length;
  int breadth;
};

int main() {
    struct rectangle a={10,5};
    cout <<"length = "<<a.length<<" , breadth = "<<a.breadth<<endl;
    return 0;
}
