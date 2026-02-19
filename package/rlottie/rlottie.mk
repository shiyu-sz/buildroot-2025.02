################################################################################
#
# rlottie
#
################################################################################

RLOTTIE_VERSION = 0.2
RLOTTIE_SITE = https://github.com/Samsung/rlottie/releases/download/v$(RLOTTIE_VERSION)
RLOTTIE_SOURCE = rlottie-$(RLOTTIE_VERSION).tar.gz
RLOTTIE_INSTALL_TARGET = YES
RLOTTIE_INSTALL_STAGING = YES
RLOTTIE_DEPENDENCIES =

RLOTTIE_CONF_OPTS =

define RLOTTIE_INSTALL_STAGING_CMDS
    # $(INSTALL) -D -m 0755 source/third-party/rlottie-0.2/inc/rlottie_capi.h $(STAGING_DIR)/usr/include/rlottie_capi.h
    # $(INSTALL) -D -m 0755 source/third-party/rlottie-0.2/inc/rlottie.h $(STAGING_DIR)/usr/include/rlottie.h
    # $(INSTALL) -D -m 0755 source/third-party/rlottie-0.2/inc/rlottiecommon.h $(STAGING_DIR)/usr/include/rlottiecommon.h

    $(INSTALL) -D -m 0755 $(@D)/inc/rlottie_capi.h $(STAGING_DIR)/usr/include/rlottie_capi.h
    $(INSTALL) -D -m 0755 $(@D)/inc/rlottie.h $(STAGING_DIR)/usr/include/rlottie.h
    $(INSTALL) -D -m 0755 $(@D)/inc/rlottiecommon.h $(STAGING_DIR)/usr/include/rlottiecommon.h

    $(INSTALL) -D -m 0755 $(@D)/librlottie.so $(STAGING_DIR)/usr/lib/librlottie.so
    $(INSTALL) -D -m 0755 $(@D)/librlottie.so.0 $(STAGING_DIR)/usr/lib/librlottie.so.0
    $(INSTALL) -D -m 0755 $(@D)/librlottie.so.0.2 $(STAGING_DIR)/usr/lib/librlottie.so.0.2
endef

define RLOTTIE_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/librlottie.so $(TARGET_DIR)/usr/lib/librlottie.so
    $(INSTALL) -D -m 0755 $(@D)/librlottie.so.0 $(TARGET_DIR)/usr/lib/librlottie.so.0
    $(INSTALL) -D -m 0755 $(@D)/librlottie.so.0.2 $(TARGET_DIR)/usr/lib/librlottie.so.0.2
endef

$(eval $(cmake-package))