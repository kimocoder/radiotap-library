LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := radiotap

LOCAL_CFLAGS := \
    -Wall \
    -Wextra \
    -Wno-address-of-packed-member \
    -D_BSD_SOURCE \
    -DRADIOTAP_SUPPORT_OVERRIDES \

LOCAL_SRC_FILES := \
    radiotap.c \

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include

include $(BUILD_SHARED_LIBRARY)
