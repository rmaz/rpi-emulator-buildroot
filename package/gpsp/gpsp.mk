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
GPSP_INCLUDES=-I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/usr/include/interface/vcos/pthreads -I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux
GPSP_CFLAGS= -DARM_ARCH -DRPI_BUILD -Wall $(SDL_FLAGS) $(GPSP_INCLUDES)
GPSP_LIBS= -ldl -lpthread -lz -L$(STAGING_DIR)/usr/lib $(SDL_LIBS) -lGLESv2 -lEGL -lopenmaxil -lbcm_host -lvcos -lvchiq_arm -lrt -lvchostif

define GPSP_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) $(GPSP_CFLAGS)" \
		LIBS="$(GPSP_LIBS)" \
		-C $(@D)/raspberrypi all
endef

define GPSP_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/raspberrypi/gpsp \
		$(TARGET_DIR)/usr/emulators/gba/gpsp
	$(INSTALL) -D $(@D)/game_config.txt \
		$(TARGET_DIR)/usr/emulators/gba/game_config.txt
endef

$(eval $(generic-package))
