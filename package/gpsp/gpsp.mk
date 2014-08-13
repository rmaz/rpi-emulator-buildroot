################################################################################
#
# gpsp
#
################################################################################
GPSP_VERSION = d884dfcc1bf6951473b28cda5d34cceec093a263
GPSP_SITE = $(call github,gizmo98,gpsp,$(GPSP_VERSION))
GPSP_DEPENDENCIES = sdl
SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl-config
SDL_FLAGS=`$(SDL_CONFIG) --cflags`
SDL_LIBS=`$(SDL_CONFIG) --libs`
GPSP_CFLAGS=$(SDL_FLAGS) -I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/usr/include/interface/vcos/pthreads -I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux
GPSP_LIBS=$(SDL_LIBS) -ldl -lpthread -lGLESv2 -lEGL -lopenmaxil -lbcm_host -lvcos -lvchiq_arm  -lrt

define GPSP_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) $(GPSP_CFLAGS)" \
		LIBS="$(GPSP_LIBS)" \
		-C $(@D)/raspberrypi all
endef

define GPSP_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
