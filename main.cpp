#include "main.h"

using namespace std;

int main() {

    Person people[LIST_SIZE];

    cout << "=== Survey Records ===" << endl;
    cout << "------------------------" << endl;

    for (int i = 0; i < LIST_SIZE; i++)
    {
        cout << "Person " << i + 1 << ":" << endl;
        cout << "  First Name: ";
        cin >> people[i].first_name;
        cout << "  Last Name:  ";
        cin >> people[i].last_name;
        cout << "  Age:        ";
        cin >> people[i].age;
        cout << endl;
    }

    cout << "------------------------" << endl;
    cout << "All Records:" << endl;
    cout << "------------------------" << endl;
    showAll(people, LIST_SIZE);

    cout << "------------------------" << endl;
    cout << "Youngest Age: ";
    showYoungest(people, LIST_SIZE);   // ASM prints the value via WriteDec

    cout << "Oldest Age:   ";
    showOldest(people, LIST_SIZE);     // ASM prints the value via WriteDec

    cout << "Average Age:  ";
    showAverage(people, LIST_SIZE);    // ASM prints the value via WriteDec

    cout << "------------------------" << endl;
    cout << "Terminated" << endl;

    return 0;
}