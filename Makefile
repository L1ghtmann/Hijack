export DEBUG=0
export ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

SUBPROJECTS += HijackApps
SUBPROJECTS += HijackSB
SUBPROJECTS += HijackPrefs

include $(THEOS_MAKE_PATH)/aggregate.mk
