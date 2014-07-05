################################################################################
#
# dejavu
#
################################################################################

DEJAVU_VERSION = 2.34
DEJAVU_SITE = http://sourceforge.net/projects/dejavu/files/dejavu/$(DEJAVU_VERSION)
DEJAVU_SOURCE = dejavu-fonts-ttf-$(DEJAVU_VERSION).tar.bz2
DEJAVU_LICENSE_FILES = LICENSE

DEJAVU_TARGET_DIR = $(TARGET_DIR)/usr/share/fonts/dejavu
DEJAVU_FONTCONFIG_TARGET_DIR = $(TARGET_DIR)/usr/share/fontconfig/conf.avail

ifeq ($(BR2_PACKAGE_DEJAVU_MONO),y)
define DEJAVU_INSTALL_MONO
	$(INSTALL) -m 644 $(@D)/ttf/DejaVuSansMono*.ttf $(DEJAVU_TARGET_DIR)
	$(INSTALL) -m 644 $(@D)/fontconfig/20-unhint-small-dejavu-sans-mono.conf $(DEJAVU_FONTCONFIG_TARGET_DIR)
	$(INSTALL) -m 644 $(@D)/fontconfig/57-dejavu-sans-mono.conf $(DEJAVU_FONTCONFIG_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_DEJAVU_SANS),y)
define DEJAVU_INSTALL_SANS
	$(INSTALL) -m 644 $(@D)/ttf/DejaVuSans.ttf $(DEJAVU_TARGET_DIR)
	$(INSTALL) -m 644 $(@D)/ttf/DejaVuSans-*.ttf $(DEJAVU_TARGET_DIR)
	$(INSTALL) -m 644 $(@D)/fontconfig/20-unhint-small-dejavu-sans.conf $(DEJAVU_FONTCONFIG_TARGET_DIR)
	$(INSTALL) -m 644 $(@D)/fontconfig/57-dejavu-sans.conf $(DEJAVU_FONTCONFIG_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_DEJAVU_SERIF),y)
define DEJAVU_INSTALL_SERIF
	$(INSTALL) -m 644 $(@D)/ttf/DejaVuSerif.ttf $(DEJAVU_TARGET_DIR)
	$(INSTALL) -m 644 $(@D)/ttf/DejaVuSerif-*.ttf $(DEJAVU_TARGET_DIR)
	$(INSTALL) -m 644 $(@D)/fontconfig/20-unhint-small-dejavu-serif.conf $(DEJAVU_FONTCONFIG_TARGET_DIR)
	$(INSTALL) -m 644 $(@D)/fontconfig/57-dejavu-serif.conf $(DEJAVU_FONTCONFIG_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_DEJAVU_SANS_CONDENSED),y)
define DEJAVU_INSTALL_SANS_CONDENSED
	$(INSTALL) -m 644 $(@D)/ttf/DejaVuSansCondensed*.ttf $(DEJAVU_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_DEJAVU_SERIF_CONDENSED),y)
define DEJAVU_INSTALL_SERIF_CONDENSED
	$(INSTALL) -m 644 $(@D)/ttf/DejaVuSerifCondensed*.ttf $(DEJAVU_TARGET_DIR)
endef
endif

define DEJAVU_INSTALL_TARGET_CMDS
	mkdir -p $(DEJAVU_TARGET_DIR)
	mkdir -p $(DEJAVU_FONTCONFIG_TARGET_DIR)
	$(DEJAVU_INSTALL_MONO)
	$(DEJAVU_INSTALL_SANS)
	$(DEJAVU_INSTALL_SERIF)
	$(DEJAVU_INSTALL_SANS_CONDENSED)
	$(DEJAVU_INSTALL_SERIF_CONDENSED)
endef

$(eval $(generic-package))
