################################################################################
#
# fbdoom
#
################################################################################

FBDOOM_VERSION = 476a0cef4a3068015f85993bc916fca38bc2d970
FBDOOM_SITE = $(call github,maximevince,fbDOOM,$(FBDOOM_VERSION))
FBDOOM_LICENSE = MIT
FBDOOM_LICENSE_FILES = README.TXT

define FBDOOM_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/fbdoom NOSDL=1 all
endef

define FBDOOM_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/fbdoom/fbdoom $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(FBDOOM_PKGDIR)/src/start_fbdoom $(TARGET_DIR)/usr/bin/
endef

define FBDOOM_POST_INSTALL_INITTAB
	$(INSTALL) -D -m 0755 $(FBDOOM_PKGDIR)/fs-overlay/etc/inittab\
	                      $(TARGET_DIR)/etc/inittab
endef

ifeq ($(BR2_PACKAGE_FBDOOM_AUTOSTART),y)
FBDOOM_POST_INSTALL_TARGET_HOOKS += FBDOOM_POST_INSTALL_INITTAB
endif

$(eval $(generic-package))
