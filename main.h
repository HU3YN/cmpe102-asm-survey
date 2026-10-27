#include <iostream>
#define STR_LEN 20
#define LIST_SIZE 4

using namespace std;

struct Person {
    int age;
    char first_name[STR_LEN];
    char last_name[STR_LEN];
};

// Bug 2 fix: renamed typedef alias so it doesn't clash with parameter name 'p'
typedef struct Person PersonType;

extern "C"
{
    // Bug 1 fix: v* -> Person*  |  Bug 2 fix: param renamed from 'p' to 'arr'
    void showAll(Person* arr, int sz);
    void showYoungest(Person* arr, int sz);
    void showOldest(Person* arr, int sz);
    void showAverage(Person* arr, int sz);
}