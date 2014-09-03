LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := mixer_paths.xml
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)

include $(BUILD_SYSTEM)/base_rules.mk

SRC_FILES := mixer_paths_stock.xml \
             mixer_paths_adaptation.xml \
             mixer_paths_cm.xml

$(LOCAL_BUILT_MODULE) : $(SRC_FILES)
        echo '<xml version="1.0" ?><mixer>' && cat $(SRC_FILES) && echo '</mixer>' > $@
