#include <iostream>
#include "CLI11.hpp"
using namespace std;

int main(int argc, char* argv[])
{

    CLI::App app{"Мое приложение"};
    int age = 0;
    string userName = "no name";

    auto t = time(nullptr);
    auto lt = localtime(&t);
    int curentYear = lt->tm_year+1900;

    app.add_option("-y,--year",age,"возраст пользователя");
    app.add_option("-n,--name",userName,"имя пользователя");

    CLI11_PARSE(app, argc, argv);
    cout << "привет " << userName << endl;
    cout << "Твой возраст " << curentYear-age << endl;
    return 0;
}
