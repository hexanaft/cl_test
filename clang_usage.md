
# Начало!
Устанавливаем WSL  
Качаем alpine-minirootfs  
https://alpinelinux.org/downloads/  
https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-minirootfs-3.16.1-x86_64.tar.gz  
Добавляем дистрибутив в wsl:  
wsl --import MyCustomDistro C:\Directory\For\Custom\WSL .\alpine.tar.gz  
Запускаем  
wsl -d MyCustomDistro  

Второрй способ chroot:  
sudo chroot alpine_tree16/ /bin/sh  
а внутри сделать  
source /etc/profile  

apk update  
apk upgrade  

vi /etc/resolv.conf  
'''  
nameserver 8.8.8.8  
nameserver 8.8.4.4  
'''  

apk add g++ libc-dev clang clang-dev clang-libs clang-static lld llvm13 llvm13-static file ninja cmake zlib-dev zlib-static musl-dev compiler-rt compiler-rt-static git  
apk add --no-cache openrc  
apk add openssh  
vi /etc/ssh/sshd_config  
>  "PermitRootLogin yes"  
rc-update add sshd  
rc-status  
service sshd restart  
touch /run/openrc/softlevel  
 
 


создать
/etc/profile.d/set_clang_path.sh >
и поместить туда
export PATH=$HOME/.llvm/bin:$PATH

сделать еще раз 
source /etc/profile

проверить
echo $PATH




clang++ --target=arm-linux-gnueabihf --sysroot=/home/sysroot-k2h t.cpp --verbose -I/home/sysroot-k2h/usr/include/c++/6.2.1/ -I/home/sysroot-k2h/usr/include/c++/6.2.1/arm-linux-gnueabihf/ -fuse-ld=lld

arm-linux-gnueabihf-clang

exec /usr/bin/clang -B$HOME/.llvm/bin --target=arm-linux-gnueabihf --sysroot=$HOME/sysroot-k2h -I/home/sysroot-k2h/usr/include/c++/6.2.1/ -I/home/sysroot-k2h/usr/include/c++/6.2.1/arm-linux-gnueabihf/ "$@"


arm-linux-gnueabihf-clang++

exec /usr/bin/clang++ -B/root/.llvm/bin --target=arm-linux-gnueabihf -stdlib=libc++ --sysroot=/home/sysroot-k2h -I/home/sysroot-k2h/usr/include/c++/6.2.1/ -I/home/sysroot-k2h/usr/include/c++/6.2.1/arm-linux-gnueabihf/ "$@"

x86_64-linux-musl-clang++

exec /usr/bin/clang++ -B/root/.llvm/bin --gcc-toolchain=/home/sysroot-k2h/usr --target=arm-linux-gnueabihf -stdlib=libc++ --sysroot=/home/sysroot-k2h -I/home/sysroot-k2h/usr/include/c++/6.2.1/ -I/home/sysroot-k2h/usr/include/c++/6.2.1/arm-linux-gnueabihf/ "$@"


export PATH=$HOME/.llvm/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/clang_14.0.4/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH



file make_llvm_env.sh
```
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
export C_INCLUDE_PATH=/usr/include/:"\$C_INCLUDE_PATH"
export CPLUS_INCLUDE_PATH=/usr/include/c++/11.2.1/:"\$CPLUS_INCLUDE_PATH"
EOF

source /etc/profile

echo $PATH

```

file clear_llvm_env.sh
```
#!/usr/bin/env sh
# -*- coding: utf-8 -*-

# exit when any command fails
set -e

rm /etc/profile.d/set_clang_path.sh
source /etc/profile
rm -rf ~/.local
rm -rf ~/.llvm
```












































