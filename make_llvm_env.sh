#!/usr/bin/env sh
# -*- coding: utf-8 -*-

# exit when any command fails
set -e

mkdir ~/.llvm
mkdir ~/.llvm/bin
ln -sv /usr/bin/llvm-ar ~/.llvm/bin/ar
ln -sv /usr/bin/lld ~/.llvm/bin/ld
ln -sv /usr/bin/llvm-objcopy ~/.llvm/bin/objcopy
ln -sv /usr/bin/llvm-objdump ~/.llvm/bin/objdump
ln -sv /usr/bin/llvm-ranlib ~/.llvm/bin/ranlib
ln -sv /usr/bin/llvm-strings ~/.llvm/bin/strings
ln -sv /usr/bin/llvm-strip ~/.llvm/bin/strip

mkdir ~/.local
mkdir ~/.local/bin

echo ~/.local/bin/x86_64-alpine-linux-musl-clang
cat << EOF > ~/.local/bin/x86_64-alpine-linux-musl-clang
#!/usr/bin/env sh
exec /usr/bin/clang \
-B\$HOME/.llvm/bin \
--target=x86_64-alpine-linux-musl \
-I/usr/include/ \
-I/usr/include/c++/11.2.1/ \
-I/usr/include/c++/11.2.1/x86_64-alpine-linux-musl \
-L/lib \
"\$@"
EOF
chmod +x ~/.local/bin/x86_64-alpine-linux-musl-clang

echo ~/.local/bin/x86_64-alpine-linux-musl-clang++
cat << EOF > ~/.local/bin/x86_64-alpine-linux-musl-clang++
#!/usr/bin/env sh
exec /usr/bin/clang++ \
-B\$HOME/.llvm/bin \
-stdlib=libstdc++ \
--target=x86_64-alpine-linux-musl \
-I/usr/include/ \
-I/usr/include/c++/11.2.1/ \
-I/usr/include/c++/11.2.1/x86_64-alpine-linux-musl \
-L/lib \
"\$@"
EOF
chmod +x ~/.local/bin/x86_64-alpine-linux-musl-clang++

echo ~/.local/bin/arm-linux-gnueabihf-clang
cat << EOF > ~/.local/bin/arm-linux-gnueabihf-clang
#!/usr/bin/env sh
exec /usr/bin/clang \
-B\$HOME/.llvm/bin \
--target=arm-linux-gnueabihf \
--sysroot=$HOME/sysroot-k2h \
-I$HOME/sysroot-k2h/usr/include/c++/6.2.1/ \
-I$HOME/sysroot-k2h/usr/include/c++/6.2.1/arm-linux-gnueabihf/ \
-fuse-ld=lld \
"\$@"
EOF
chmod +x ~/.local/bin/arm-linux-gnueabihf-clang

echo ~/.local/bin/arm-linux-gnueabihf-clang++
cat << EOF > ~/.local/bin/arm-linux-gnueabihf-clang++
#!/usr/bin/env sh
exec /usr/bin/clang \
-B\$HOME/.llvm/bin \
--target=arm-linux-gnueabihf \
--sysroot=$HOME/sysroot-k2h \
-I$HOME/sysroot-k2h/usr/include/c++/6.2.1/ \
-I$HOME/sysroot-k2h/usr/include/c++/6.2.1/arm-linux-gnueabihf/ \
-fuse-ld=lld \
"\$@"
EOF
chmod +x ~/.local/bin/arm-linux-gnueabihf-clang++



cat << EOF > /etc/profile.d/set_clang_path.sh
export PATH=\$HOME/.local/bin:"\$PATH"
EOF

# source /etc/profile

echo PATH = $PATH

#export C_INCLUDE_PATH=/usr/include/:"\$C_INCLUDE_PATH"
#export CPLUS_INCLUDE_PATH=/usr/include/c++/11.2.1/:"\$CPLUS_INCLUDE_PATH"
