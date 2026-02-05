################################################################################
#
# raspberrypi5_overlay
#
################################################################################
 
RASPBERRYPI5_OVERLAY_VERSION:= 1.0.0
RASPBERRYPI5_OVERLAY_SITE:= $(TOPDIR)/package/raspberrypi5_overlay
RASPBERRYPI5_OVERLAY_SITE_METHOD:=local
RASPBERRYPI5_OVERLAY_INSTALL_TARGET:=YES
 
define RASPBERRYPI5_OVERLAY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/S99raspberrypi5_overlay $(TARGET_DIR)/etc/init.d/S99raspberrypi5_overlay
    # $(INSTALL) -D -m 0755 $(@D)/S99raspberrypi5_overlay.service $(TARGET_DIR)/usr/lib/systemd/user/S99raspberrypi5_overlay.service
endef
 
$(eval $(generic-package))