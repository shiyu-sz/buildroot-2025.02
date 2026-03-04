################################################################################
#
# lv_port_linux_v9
#
################################################################################

LV_PORT_LINUX_V9_VERSION = 1.0.0
LV_PORT_LINUX_V9_SITE = ./package/1-example/lv_port_linux_v9
LV_PORT_LINUX_V9_SITE_METHOD = local
LV_PORT_LINUX_V9_DEPENDENCIES = libdrm

define LV_PORT_LINUX_V9_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define LV_PORT_LINUX_V9_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/build/bin/lvgl_demo $(TARGET_DIR)/usr/bin
endef
 
define LV_PORT_LINUX_V9_PERMISSIONS
    /usr/bin/lvgl_demo f 4755 0 0 - - - - -
endef
 
$(eval $(generic-package))