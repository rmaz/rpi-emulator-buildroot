################################################################################
#
# gpsp
#
################################################################################
GPSP_VERSION = d884dfcc1bf6951473b28cda5d34cceec093a263
GPSP_SITE = $(call github,gizmo98,gpsp,$(GPSP_VERSION))
GPSP_DEPENDENCIES = sdl
GPSP_CFLAGS = -DARM_ARCH -DRPI_BUILD -Wall `sdl-config --cflags` -Ofast -mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s -fgnu89-inline -I${includedir} -I${includedir}/interface/vcos/pthreads -I${includedir}/interface/vmcs_host/linux
GPSP_LIBS = `sdl-config --libs` -ldl -lpthread -L${libdir} -lGLESv2 -lEGL -lopenmaxil -lbcm_host -lvcos -lvchiq_arm  -lrt

define GPSP_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) $(GPSP_CFLAGS)" \
		LIBS="$(GPSP_LIBS)" -C $(@D)/raspberrypi all
endef

define GPSP_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
