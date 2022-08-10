#!/usr/bin/env sh
# -*- coding: utf-8 -*-

set -e # Exit immediately if a command exits with a non-zero exit status.
set -x # Print commands and their arguments as they are executed.

QEMU_VERSION="7.1.0-rc1" #"7.0.0-7"
QEMU_TYPE="arm" # arm aarch64 microblaze mips

BINFMT_VERSION="2.2.2"

function wget_bin_qemu() {
    wget https://github.com/multiarch/qemu-user-static/releases/download/v${QEMU_VERSION}/qemu-${QEMU_TYPE}-static.tar.gz
}

function wget_git_qemu_src_rls() {
    wget https://github.com/qemu/qemu/archive/refs/tags/v${QEMU_VERSION}.zip
}

function clone_git_and_build_qemu_src() { # http://logan.tw/posts/2018/02/18/build-qemu-user-static-from-source-code/
    git clone https://github.com/qemu/qemu.git
    cd qemu
    git checkout tags/v${QEMU_VERSION}
    git submodule update --init --recursive
    ./configure --prefix=$(cd ..; pwd)/qemu-user-static --static --disable-system --enable-linux-user
    # Specifying --disable-system disables softmmu targets
    cd build
    ninja
    ninja install
    cd ..
    cd ../qemu-user-static/bin
    for i in *; do mv $i $i-static; done
}

# https://gitlab.com/cjwatson/binfmt-support
function wget_binfmt_rls_build() {
    # git clone https://gitlab.com/cjwatson/binfmt-support.git
    wget https://download.savannah.nongnu.org/releases/binfmt-support/binfmt-support-${BINFMT_VERSION}.tar.gz
    tar -xvf binfmt-support-${BINFMT_VERSION}.tar.gz binfmt-support-${BINFMT_VERSION}
    cd binfmt-support-${BINFMT_VERSION}/
    mkdir build
    cd build
    apk add libpipeline libpipeline-dev

    ../configure
    make
    make install
}

# mount | grep binfmt_misc

# function run_qemu_chroot() {
#     qemu=$(which qemu-arm-static)
#     cp ${qemu} ${target}/${qemu}
#     chroot ${target} /bin/ash
# }

# wget_bin_qemu;
# wget_git_qemu_src_rls;
# clone_git_and_build_qemu_src;

# while getopts 'a:b:d:i:k:m:p:r:t:hv' OPTION; do
# 	case "$OPTION" in
# 		a) ARCH="$OPTARG";;
# 		b) ALPINE_BRANCH="$OPTARG";;
# 		d) CHROOT_DIR="$OPTARG";;
# 		i) BIND_DIR="$OPTARG";;
# 		k) CHROOT_KEEP_VARS="${CHROOT_KEEP_VARS:-} $OPTARG";;
# 		m) ALPINE_MIRROR="$OPTARG";;
# 		p) ALPINE_PACKAGES="${ALPINE_PACKAGES:-} $OPTARG";;
# 		r) EXTRA_REPOS="${EXTRA_REPOS:-} $OPTARG";;
# 		t) TEMP_DIR="$OPTARG";;
# 		h) usage; exit 0;;
# 		v) echo "alpine-chroot-install $VERSION"; exit 0;;
# 	esac
# done

# https://wiki.alpinelinux.org/wiki/How_to_make_a_cross_architecture_chroot
# https://github.com/jirutka/qemu-openrc
# https://wiki.gentoo.org/wiki/Crossdev_qemu-static-user-chroot
# https://askubuntu.com/questions/1204407/why-cant-ubuntu-18-04-chroot-into-a-qemu-environment