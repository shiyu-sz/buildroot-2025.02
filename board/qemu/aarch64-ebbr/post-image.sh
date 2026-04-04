#!/bin/sh
set -eu

BOARD_DIR=$(dirname "$0")

# Create flash.bin TF-A FIP image from bl1.bin and fip.bin
dd if="${BINARIES_DIR}/bl1.bin" of="${BINARIES_DIR}/flash.bin" bs=1M
dd if="${BINARIES_DIR}/fip.bin" of="${BINARIES_DIR}/flash.bin" seek=64 bs=4096 conv=notrunc

# Override the default GRUB configuration file with our own.
# cp -f "${BOARD_DIR}/grub.cfg" "${BINARIES_DIR}/efi-part/EFI/BOOT/grub.cfg"

# 确保 mkimage 工具可用并生成脚本
${HOST_DIR}/bin/mkimage -A arm64 -O linux -T script -C none -a 0 -e 0 \
    -n "boot script" -d ${BOARD_DIR}/boot.cmd ${BINARIES_DIR}/boot.scr

# 创建一个空的环境变量文件，大小为 256KB，放在 1MB 偏移处
dd if=/dev/zero of=${BINARIES_DIR}/uboot-env.bin bs=1k count=256