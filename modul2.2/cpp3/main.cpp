#include <iostream>
#include <string>
#include <cstdlib>
using namespace std;

int main(int argc, char* argv[]){
    string line;
    int min = 0;
    bool first = true; // флаг для первого числа
    while (true) {
        getline(cin, line); //счет цифр которые мы ввели
        if (line == "") // если строка пустая, то выходим из цикла
            break;
        int num = atoi(line.c_str()); //переделываем строчку в число
        if (first){
            min = num; // первое число сразу min
            first = false;
        } else if (min > num){
            min = num;
        }
    }
    cout << "Min число: " << min << endl;
    return 0;
}
