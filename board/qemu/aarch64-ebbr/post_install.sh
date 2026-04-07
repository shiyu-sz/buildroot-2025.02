#!/bin/sh
# 获取当前 boot_slot 变量
CURRENT_SLOT=$(fw_printenv -n boot_slot)

if [ "$CURRENT_SLOT" = "A" ]; then
    fw_setenv boot_slot B
    echo "Upgrade successful: Next boot from Slot B"
else
    fw_setenv boot_slot A
    echo "Upgrade successful: Next boot from Slot A"
fi

# 这一步很重要：告诉 U-Boot 有新固件需要尝试启动
fw_setenv upgrade_available 1
fw_setenv bootcount 0

exit 0