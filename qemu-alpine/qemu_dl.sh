#!/usr/bin/env sh
# -*- coding: utf-8 -*-

set -e # Exit immediately if a command exits with a non-zero exit status.
set -x # Print commands and their arguments as they are executed.


function download_qemu() {
#   wget http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VER}/releases/${ALPINE_TYPE}/alpine-uboot-${ALPINE_VERSION}-${ALPINE_TYPE}.tar.gz
#   wget http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VER}/releases/${ALPINE_TYPE}/alpine-minirootfs-${ALPINE_VERSION}-${ALPINE_TYPE}.tar.gz

    git clone git://git.qemu.org/qemu.git
}

download_qemu;