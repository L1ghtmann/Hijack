export DEBUG = 0
export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:13.0

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

SUBPROJECTS += HijackApps HijackPrefs HijackSB

include $(THEOS_MAKE_PATH)/aggregate.mk
