ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WiggleDots

WiggleDots_FILES = Tweak.xm
$(TWEAK_NAME)_FRAMEWORKS = AudioToolbox
WiggleDots_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
