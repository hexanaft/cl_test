#!/usr/bin/env sh
# -*- coding: utf-8 -*-

set -e # Exit immediately if a command exits with a non-zero exit status.
set -x # Print commands and their arguments as they are executed.

curdir=`pwd`
ALPINE_VER="3.16"
ALPINE_VERSION="3.16.1"
ALPINE_TYPE="armv7" # armv7 armhf

function download_alpine() {
  wget http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VER}/releases/${ALPINE_TYPE}/alpine-uboot-${ALPINE_VERSION}-${ALPINE_TYPE}.tar.gz
  wget http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VER}/releases/${ALPINE_TYPE}/alpine-minirootfs-${ALPINE_VERSION}-${ALPINE_TYPE}.tar.gz
}

# http://dl-cdn.alpinelinux.org/alpine/v3.16/releases/armhf/alpine-minirootfs-3.16.1-armhf.tar.gz

# qemu-img create -f raw sd.img 512M

# sudo losetup /dev/loop0 sd.img 
# sudo kpartx -av /dev/loop0
# lsblk
# sudo mkfs.ext4 /dev/mapper/loop0p1
# mount -t ext4 /dev/mapper/loop0p1 /mnt

# sudo cp alpine-minirootfs-3.7.0-armhf.tar.gz /mnt/
# sudo cp alpine-uboot-3.7.0-armhf.tar.gz /mnt
# sudo cd /mnt/
# sudo tar xzvf alpine-minirootfs-3.7.0-armhf.tar.gz 
# sudo tar xzvf alpine-uboot-3.7.0-armhf.tar.gz
# sudo rm alpine-minirootfs-3.7.0-armhf.tar.gz
# sudo rm alpine-uboot-3.7.0-armhf.tar.gz
# sudo umount /mnt
# sudo kpartx -dv /dev/loop0
# sudo losetup -d /dev/loop0

# file sd.img 
#   #sd.img: DOS/MBR boot sector; partition 1 : ID=0x83, start-CHS (0x10,0,1), end-CHS (0x3ff,3,32), startsector 2048, 1046528 sectors
# rm alpine-*
# ls
#   #alpine.apkovl.tar.gz  apks  boot  extlinux  sd.img  u-boot

# qemu-system-arm -sd sd.img -m 256 -M vexpress-a9 -dtb boot/dtbs/vexpress-v2p-ca9.dtb -kernel boot/vmlinuz-hardened -initrd boot/initramfs-hardened -append "modules=loop,squashfs,sd-mod,usb-storage,ext4 modloop=/boot/modloop-hardened root=/dev/mmcblk0 console=ttyAMA0" -nographic

download_alpine;

