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
GPSP_CFLAGS= -DARM_ARCH -DRPI_BUILD -Wall -Ofast -mfpu=vfp -mfloat-abi=hard -march=armv6j -fgnu89-inline $(SDL_FLAGS) -I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/usr/include/interface/vcos/pthreads -I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux
GPSP_LIBS= -ldl -lpthread -lz -L$(STAGING_DIR)/usr/lib $(SDL_LIBS) -lGLESv2 -lEGL -lopenmaxil -lbcm_host -lvcos -lvchiq_arm  -lrt

define GPSP_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) $(GPSP_CFLAGS)" \
		LIBS="$(GPSP_LIBS)" \
		-C $(@D)/raspberrypi all
endef

define GPSP_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/gpsp \
		$(TARGET_DIR)/usr/emulators/gpsp
endef

$(eval $(generic-package))
