
// Regular shared link
// RUN: %clang++ %s -stdlib=libc++

// Static link via -static-libstdc++
// RUN: %clang++ %s -stdlib=libc++ -static-libstdc++

// Static link via -static
// RUN: %clang++ %s -stdlib=libc++ -static

// Both
// RUN: %clang++ %s -stdlib=libc++ -static-libstdc++ -static

#include <iostream>
//#include <chrono>
//#include <cmath>
#include <cstdio>
//#include <vector>
//#include <functional>
//#include <algorithm>
//#include <cstring>
//#include <cinttypes>
//#include <typeinfo>

//void Randomize() { std::srand( static_cast<uint32_t>( std::time( nullptr ) ) ); }

//uint32_t Random(uint32_t min, uint32_t max)
//{
//    return (min + (static_cast<uint32_t>(std::rand()) % (max - min + 1)));
//}

int main(int argc, char **argv) 
{
    setbuf(stdout, nullptr); // TODO: remove, need only for debug on cross gdb

    int a = 6;
    int b = 7;
    int c = a+++b;
    printf("Test_%u: a %d, b %d, c %d\n", __LINE__, a, b, c);

    std::cout << "Hello Word\n";
    return 0;
}

