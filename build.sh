#!/bin/bash

build_clean() {
    rm -rf output
    rm -rf .config
}

build_aarch64() {
    # cp qemu_aarch64_virt_defconfig .config
    cp qemu_aarch64_ebbr_defconfig .config
    make -j$(grep -c ^processor /proc/cpuinfo)
    # make CCACHE_OPTIONS="--max-size=20G" ccache-options
    # make ccache-stats
}

build_x86_64() {
    cp qemu_x86_64_defconfig .config
    make -j$(grep -c ^processor /proc/cpuinfo)
}

build_flutter() {
    cp flutter_qemu_x86_64_defconfig .config
    make -j$(grep -c ^processor /proc/cpuinfo)
}

run_aarch64() {
    # 原启动脚本
    # qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -smp 1 \
    #     -kernel output/images/Image -append "rootwait root=/dev/vda console=ttyAMA0" \
    #     -netdev user,id=eth0 -device virtio-net-device,netdev=eth0 \
    #     -drive file=output/images/rootfs.ext4,if=none,format=raw,id=hd0 -device virtio-blk-device,drive=hd0
    # 用于测试图形输出的脚本
    # qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -smp 1 \
    #     -kernel output/images/Image -append "rootwait root=/dev/vda console=ttyAMA0" \
    #     -netdev user,id=eth0 -device virtio-net-device,netdev=eth0 \
    #     -drive file=output/images/rootfs.ext4,if=none,format=raw,id=hd0 \
    #     -device virtio-blk-device,drive=hd0 -device virtio-gpu-device \
    #     -device virtio-mouse-pci -device virtio-keyboard-pci -display sdl
    # 测试ebbr，使用uboot引导
      qemu-system-aarch64 \
        -M virt,secure=on,acpi=off \
        -bios output/images/flash.bin \
        -cpu cortex-a53 \
        -device virtio-blk-device,drive=hd0 \
        -device virtio-net-device,netdev=eth0 \
        -device virtio-rng-device,rng=rng0 \
        -drive file=output/images/disk.img,if=none,format=raw,id=hd0 \
        -m 1024 \
        -netdev user,id=eth0,hostfwd=tcp::8080-:8080 \
        -nographic \
        -object rng-random,filename=/dev/urandom,id=rng0 \
        -rtc base=utc,clock=host \
        -smp 2 # qemu_aarch64_ebbr_defconfig
}

run_x86_64() {
    qemu-system-x86_64 -M pc -m 512M \
        -kernel output/images/bzImage \
        -drive file=output/images/rootfs.ext2,if=virtio,format=raw \
        -append "rootwait root=/dev/vda console=tty1 console=ttyS0" \
        -serial stdio -net nic,model=virtio -net user \
        -vga virtio \
        -device virtio-vga-gl \
        -display gtk,gl=on
}

run_flutter() {
    qemu-system-x86_64 -M pc -m 512M \
        -kernel output/images/bzImage \
        -drive file=output/images/rootfs.ext2,if=virtio,format=raw \
        -append "rootwait root=/dev/vda console=tty1 console=ttyS0" \
        -serial stdio -net nic,model=virtio -net user \
        -vga virtio \
        -device virtio-vga-gl \
        -display gtk,gl=on \
        -virtfs local,path=/home/sy,mount_tag=host0,security_model=mapped-xattr
}

# mkdir -p /mnt/shared
# mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt/shared

build_package() {
    make ${1}-rebuild
    make
}

if test "$1" = "clean" ; then
    build_clean
elif test "$1" = "aarch64" ; then
    build_aarch64
elif test "$1" = "run_aarch64" ; then
    run_aarch64
elif test "$1" = "x86_64" ; then
    build_x86_64
elif test "$1" = "run_x86_64" ; then
    run_x86_64
elif test "$1" = "flutter" ; then
    build_flutter
elif test "$1" = "run_flutter" ; then
    run_flutter
else
    build_package $1
fi
