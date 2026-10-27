# Mixed C++ and x86 assembly survey program (CMPE 102, SJSU)

C++ collects a survey of 4 people (first name, last name, age). Four assembly procedures then display the results: all records, the youngest age, the oldest age and the average age. The assembly writes its own output with the Irvine32 library. Solo project, Jan to Jun 2026.

C++ defines a `Person` struct (an age plus two 20-character name fields) and calls the procedures through `extern "C"`. The assembly mirrors the struct and walks the array in a loop, comparing ages for the min and max and summing them for the average.

I found and fixed eight bugs (noted in the code comments): a wrong pointer type in the C++ declarations, a name clash between a typedef and a parameter, struct fields in a different order from C++, a missing comma, an inverted comparison, an off-by-one loop count, and two procedures that computed a result but never displayed it.

Known limit: three of the four procedures use ESI (and two use EBX) without saving them, which the C calling convention expects.

Built with MASM and Irvine32.
