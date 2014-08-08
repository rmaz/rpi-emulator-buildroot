################################################################################
#
# gpsp
#
################################################################################
GPSP_VERSION = d884dfcc1bf6951473b28cda5d34cceec093a263
GPSP_SITE = https://github.com/gizmo98/gpsp.git
GPSP_SITE_METHOD = git
#RETROARCH_LICENSE = GPLv3+
#RETROARCH_CONF_OPT += --disable-netplay --disable-oss 
#--disable-bsv_movie
#RETROARCH_DEPENDENCIES = host-pkgconf

define GPSP_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define GPSP_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
