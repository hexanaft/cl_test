#!/usr/bin/env sh
# -*- coding: utf-8 -*-

# exit when any command fails
set -e

# x86_64-alpine-linux-musl-clang --version
# x86_64-alpine-linux-musl-clang++ --version

rm -rf out
mkdir out
cd out
# x86_64-alpine-linux-musl-clang++ -o testcpp ../test.cpp -stdlib=libc++ -static-libstdc++ -static --verbose
x86_64-alpine-linux-musl-clang -O3 -g0 -o test1 ../test.c -static
strip test1 -v
file test1