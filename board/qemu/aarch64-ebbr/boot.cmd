echo "--- SWUpdate A/B Boot Script ---"

# 1. 强制覆盖地址变量，避免 overwrite 报错
setenv kernel_addr_r 0x44000000
setenv fdt_addr_r    0x49000000
# 脚本本身在 40200000，内核在 44000000，两者之间有 60MB 空间，绝对安全

# 2. A/B 逻辑
if test -z "${boot_slot}"; then setenv boot_slot A; saveenv; fi

if test "${boot_slot}" = "A"; then
    echo "Booting from Slot A (/dev/vda2)..."
    setenv rootpart 2
else
    echo "Booting from Slot B (/dev/vda3)..."
    setenv rootpart 3
fi

# 3. 设置启动参数 (保持使用 /dev/vdaX)
setenv bootargs "console=ttyAMA0 root=/dev/vda${rootpart} rw rootwait swupdate.slot=${boot_slot}"

# 4. 执行加载过程
# 确认 Image 文件在第一个分区的根目录
if fatload virtio 0:1 ${kernel_addr_r} Image; then
    # QEMU 启动时通常会自动传 FDT 地址，如果 booti 失败，尝试手动加载 dtb
    booti ${kernel_addr_r} - ${fdt_addr}
else
    echo "CRITICAL ERROR: Could not find Image on EFI partition!"
fi