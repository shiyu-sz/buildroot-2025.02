#!/bin/bash

build_uboot() {
    make uboot-rebuild
}

build_linux() {
    make linux-rebuild
}

build_clean() {
    rm -rf output
    rm -rf .config
}

build_aarch64() {
    cp qemu_aarch64_virt_defconfig .config
    make -j8 
}

build_x86_64() {
    cp qemu_x86_64_defconfig .config
    make -j8 
}

run_aarch64() {
    # qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -smp 1 -kernel output/images/Image -append "rootwait root=/dev/vda console=ttyAMA0" -netdev user,id=eth0 -device virtio-net-device,netdev=eth0 -drive file=output/images/rootfs.ext4,if=none,format=raw,id=hd0 -device virtio-blk-device,drive=hd0
    qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -smp 1 -kernel output/images/Image -append "rootwait root=/dev/vda console=ttyAMA0" -netdev user,id=eth0 -device virtio-net-device,netdev=eth0 -drive file=output/images/rootfs.ext4,if=none,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 -device virtio-gpu-device -device virtio-mouse-pci -device virtio-keyboard-pci -display sdl
}

run_x86_64() {

}

build_package() {
    make ${1}-distclean
    make ${1}-rebuild
    make
}

if test "$1" = "uboot" ; then
    build_uboot
elif test "$1" = "linux" ; then
    build_linux
elif test "$1" = "clean" ; then
    build_clean
elif test "$1" = "aarch64" ; then
    build_aarch64
elif test "$1" = "run_aarch64" ; then
    run_aarch64
elif test "$1" = "x86_64" ; then
    build_x86_64
elif test "$1" = "run_x86_64" ; then
    run_x86_64
else
    build_package $1
fi
