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

mkdir ~/.local
mkdir ~/.local/bin

cat << EOF > ~/.local/bin/x86_64-alpine-linux-musl-clang
#!/usr/bin/env sh
exec /usr/bin/clang -B\$HOME/.llvm/bin --target=x86_64-alpine-linux-musl "\$@"
EOF
chmod +x ~/.local/bin/x86_64-alpine-linux-musl-clang

cat << EOF > ~/.local/bin/x86_64-alpine-linux-musl-clang++
#!/usr/bin/env sh
exec /usr/bin/clang++ -B\$HOME/.llvm/bin -stdlib=libc++ --target=x86_64-alpine-linux-musl "\$@"
EOF
chmod +x ~/.local/bin/x86_64-alpine-linux-musl-clang++

cat << EOF > /etc/profile.d/set_clang_path.sh
export PATH=\$HOME/.local/bin:"\$PATH"
EOF

source /etc/profile

echo $PATH

#export C_INCLUDE_PATH=/usr/include/:"\$C_INCLUDE_PATH"
#export CPLUS_INCLUDE_PATH=/usr/include/c++/11.2.1/:"\$CPLUS_INCLUDE_PATH"