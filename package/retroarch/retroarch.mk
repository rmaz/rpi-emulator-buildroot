################################################################################
#
# retroarch
#
################################################################################
RETROARCH_VERSION = 2755abc14fe25b9f32e145dcf6ec5c9569640eb8
RETROARCH_SITE = https://github.com/libretro/RetroArch.git
RETROARCH_SITE_METHOD = git
RETROARCH_LICENSE = GPLv3+
RETROARCH_CONF_OPT += --disable-netplay --disable-oss --disable-bsv_movie
RETROARCH_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_PACKAGE_SDL),y)
RETROARCH_CONF_OPT += --enable-sdl
RETROARCH_DEPENDENCIES += sdl
else
RETROARCH_CONF_OPT += --disable-sdl
endif

ifeq ($(BR2_PACKAGE_PYTHON),y)
RETROARCH_CONF_OPT += --enable-python
RETROARCH_DEPENDENCIES += python
else
RETROARCH_CONF_OPT += --disable-python
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
RETROARCH_CONF_OPT += --enable-x11
RETROARCH_DEPENDENCIES += x11r7
else
RETROARCH_CONF_OPT += --disable-x11
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
RETROARCH_CONF_OPT += --enable-alsa
RETROARCH_DEPENDENCIES += alsa-lib
else
RETROARCH_CONF_OPT += --disable-alsa
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
RETROARCH_CONF_OPT += --enable-pulse
RETROARCH_DEPENDENCIES += pulseaudio
else
RETROARCH_CONF_OPT += --disable-pulse
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
RETROARCH_CONF_OPT += --enable-gles
RETROARCH_DEPENDENCIES += libgles
else
RETROARCH_CONF_OPT += --disable-gles
endif

ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
RETROARCH_CONF_OPT += --enable-egl
RETROARCH_DEPENDENCIES += libegl
else
RETROARCH_CONF_OPT += --disable-egl
endif

ifeq ($(BR2_PACKAGE_HAS_LIBOPENVG),y)
RETROARCH_DEPENDENCIES += libopenvg
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
RETROARCH_CONF_OPT += --enable-libxml2
RETROARCH_DEPENDENCIES += libxml2
else
RETROARCH_CONF_OPT += --disable-libxml2
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
RETROARCH_CONF_OPT += --enable-zlib
RETROARCH_DEPENDENCIES += zlib
else
RETROARCH_CONF_OPT += --disable-zlib
endif

ifeq ($(BR2_PACKAGE_UDEV),y)
RETROARCH_DEPENDENCIES += udev
endif

ifeq ($(BR2_PACKAGE_FREETYPE),y)
RETROARCH_CONF_OPT += --enable-freetype
RETROARCH_DEPENDENCIES += freetype
else
RETROARCH_CONF_OPT += --disable-freetype
endif

define RETROARCH_CONFIGURE_CMDS
	(cd $(@D); rm -rf config.cache; \
		$(TARGET_CONFIGURE_ARGS) \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS) -lc" \
		./configure \
		--prefix=/usr \
		$(RETROARCH_CONF_OPT) \
	)
endef

define RETROARCH_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define RETROARCH_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
