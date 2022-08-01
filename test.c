#include <stdio.h>

int main(int argc, char ** argv)
{
    setbuf(stdout, nullptr); // TODO: remove, need only for debug on cross gdb

    int a = 6;
    int b = 7;
    int c = a+++b;
    printf("Test_%u: a %d, b %d, c %d\n", __LINE__, a, b, c);
}


