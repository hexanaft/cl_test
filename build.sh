#!/usr/bin/env sh
# -*- coding: utf-8 -*-

# exit when any command fails
set -e

rm -rf out
mkdir out
cd out

x86_64-alpine-linux-musl-clang -O3 -g0 -o test1 ../test.c -static
strip test1 -v
file test1

x86_64-alpine-linux-musl-clang -O3 -g0 -o zpipe ../zpipe.c -lz -static 
strip zpipe -v
file zpipe

x86_64-alpine-linux-musl-clang++ -O3 -g0 -o testcpp ../test.cpp -stdlib=libstdc++ -static-libstdc++ -static
strip testcpp -v
file testcpp

x86_64-alpine-linux-musl-clang++ -O3 -g0 -std=c++17 -o test17 ../test17.cpp -stdlib=libstdc++ -static-libstdc++ -static
strip test17 -v
file test17

ls -lha

cd ..

rm -rf outarm
mkdir outarm
cd outarm

arm-linux-gnueabihf-clang -O3 -g0 -o test1 ../test.c
# strip test1 -v
file test1

arm-linux-gnueabihf-clang -O3 -g0 -o zpipe ../zpipe.c -lz
# strip zpipe -v
file zpipe

arm-linux-gnueabihf-clang++ -O3 -g0 -o testcpp ../test.cpp -stdlib=libstdc++
# strip testcpp -v
file testcpp

# arm-linux-gnueabihf-clang++ -O3 -g0 -std=c++17 -o test17 ../test17.cpp -stdlib=libstdc++ -static-libstdc++
# strip test17 -v
# file test17

ls -lha
