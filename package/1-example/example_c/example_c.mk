################################################################################
#
# example_c
#
################################################################################
 
EXAMPLE_C_VERSION:= 1.0.0
EXAMPLE_C_SITE:= $(TOPDIR)/package/1-example/example_c
EXAMPLE_C_SITE_METHOD:=local
EXAMPLE_C_INSTALL_TARGET:=YES
 
define EXAMPLE_C_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

CURR_TIME=`date +"%Y%m%d%H%M%S"`
define EXAMPLE_C_INSTALL_TARGET_CMDS
    echo -e "${CURR_TIME}" > "${TARGET_DIR}/var/version"
    
    $(INSTALL) -D -m 0755 $(@D)/example_c $(TARGET_DIR)/usr/bin/example_c

	# $(INSTALL) -D -m 0755 $(@D)/S99example_c $(TARGET_DIR)/etc/init.d/S99example_c
    # $(INSTALL) -D -m 0755 $(@D)/example_c.service $(TARGET_DIR)/usr/lib/systemd/user/example_c.service
endef
 
define EXAMPLE_C_PERMISSIONS
    /usr/bin/example_c f 4755 0 0 - - - - -
endef
 
$(eval $(generic-package))