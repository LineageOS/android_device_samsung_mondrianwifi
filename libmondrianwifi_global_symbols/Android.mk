LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	camera-parameters.c \
	utext-compatibility.c

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_MODULE := libmondrianwifi_global_symbols
LOCAL_MODULE_TAGS := optional
LOCAL_SYSTEM_STATIC_LIBRARIES :=
LOCAL_SYSTEM_SHARED_LIBRARIES :=

include $(BUILD_STATIC_LIBRARY)
