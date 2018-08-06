LOCAL_PATH := $(call my-dir)

# =======================================================
include $(CLEAR_VARS)

LOCAL_MODULE := ImageConvert

LOCAL_SRC_FILES += \
           jni_imageutils.cpp \
	       rgb2yuv.cpp \
	       yuv2rgb.cpp

LOCAL_LDLIBS += -lm -llog -ldl -lz -ljnigraphics
LOCAL_CPPFLAGS += -fexceptions -frtti -std=c++11

ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
    LOCAL_ARM_MODE := arm
	LOCAL_ARM_NEON := true
endif

include $(BUILD_SHARED_LIBRARY)
#-----------------------------------------------------------------------------
