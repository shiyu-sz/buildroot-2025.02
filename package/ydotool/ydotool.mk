################################################################################
#
# ydotool
#
################################################################################

YDOTOOL_VERSION = 1.0.4
YDOTOOL_SITE = https://github.com/ReimuNotMoe/ydotool/releases/download/v$(YDOTOOL_VERSION)
YDOTOOL_SOURCE = ydotool-$(YDOTOOL_VERSION).tar.gz
YDOTOOL_INSTALL_TARGET = YES
YDOTOOL_INSTALL_STAGING = YES
YDOTOOL_DEPENDENCIES =

YDOTOOL_CONF_OPTS =

define YDOTOOL_INSTALL_STAGING_CMDS

endef

define YDOTOOL_INSTALL_TARGET_CMDS

endef

$(eval $(cmake-package))