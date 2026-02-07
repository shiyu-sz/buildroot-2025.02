################################################################################
#
# example_backtrace
#
################################################################################
 
EXAMPLE_BACKTRACE_VERSION:= 1.0.0
EXAMPLE_BACKTRACE_SITE:= $(TOPDIR)/package/1-example/example_backtrace
EXAMPLE_BACKTRACE_SITE_METHOD:=local
EXAMPLE_BACKTRACE_INSTALL_TARGET:=YES
 
define EXAMPLE_BACKTRACE_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define EXAMPLE_BACKTRACE_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/example_backtrace $(TARGET_DIR)/usr/bin
endef
 
define EXAMPLE_BACKTRACE_PERMISSIONS
    /usr/bin/example_backtrace f 4755 0 0 - - - - -
endef
 
$(eval $(generic-package))