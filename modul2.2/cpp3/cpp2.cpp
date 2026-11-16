#include <iostream>
#include "CLI11.hpp"
#include "ctime"
using namespace std;

int main(int argc, char* argv[]){
    CLI::App app{"моя поганка"};

    int max;
    int min;
    int count;

    app.add_option("--min",min,"значение min")->required();
    app.add_option("--max",max,"значение max")->required();
    app.add_option("--count",count,"кол-во")->required();
    CLI11_PARSE(app, argc, argv);

    if(min > max){
       cout << "MIN элемент ни как не может быть больше MAX элемента" << endl;
       return 1;
    }

    srand(time(nullptr));
    for (int i=0; i < count; i++){
        int rundom = min+rand() % (max-min+1);
        cout << rundom << endl;
    }
    return 0;
}
