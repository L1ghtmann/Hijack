include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = HijackPrefs

HijackPrefs_FILES = HiPRootListController.m 
HijackPrefs_LIBRARIES = applist
HijackPrefs_FRAMEWORKS = UIKit
HijackPrefs_PRIVATE_FRAMEWORKS = Preferences
HijackPrefs_INSTALL_PATH = /Library/PreferenceBundles
HijackPrefs_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/bundle.mk
