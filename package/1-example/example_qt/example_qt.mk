################################################################################
#
# example_qt
#
################################################################################

EXAMPLE_QT_VERSION = 1.0.0
EXAMPLE_QT_SITE = ./package/1-example/example_qt
EXAMPLE_QT_SITE_METHOD = local
EXAMPLE_QT_DEPENDENCIES = qt5base

define EXAMPLE_QT_CONFIGURE_CMDS
    cd $(@D) && $(QT5_QMAKE)
endef

define EXAMPLE_QT_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define EXAMPLE_QT_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/example_qt \
        $(TARGET_DIR)/usr/bin/example_qt
endef

$(eval $(generic-package))
