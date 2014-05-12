#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

## Get non-open-source specific aspects
$(call inherit-product-if-exists, vendor/samsung/mondrianwifi/mondrianwifi-vendor.mk)

## We are a tablet, not a phone
PRODUCT_CHARACTERISTICS := tablet

## overlays
DEVICE_PACKAGE_OVERLAYS += device/samsung/mondrianwifi/overlay

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Audio configuration
PRODUCT_COPY_FILES += \
    device/samsung/mondrianwifi/audio/audio_effects.conf:system/etc/audio_effects.conf \
    device/samsung/mondrianwifi/audio/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/samsung/mondrianwifi/audio/audio_policy.conf:system/etc/audio_policy.conf \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml

PRODUCT_PROPERTY_OVERRIDES += \
    af.resampler.quality=4 \
    audio.offload.buffer.size.kb=32 \
    audio.offload.gapless.enabled=false \
    av.offload.enable=true

# Thermal config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/thermal-engine-8974.conf:system/etc/thermal-engine-8974.conf

# Media Profile
PRODUCT_COPY_FILES += \
    device/samsung/mondrianwifi/media/media_profiles.xml:system/etc/media_profiles.xml

# Extended media support
PRODUCT_PACKAGES += \
    qcmediaplayer

PRODUCT_BOOT_JARS += qcmediaplayer

# support for epen
PRODUCT_COPY_FILES += \
    device/samsung/mondrianwifi/sec_e-pen.idc:system/usr/idc/sec_e-pen.idc

# GPS
PRODUCT_PACKAGES += \
    gps.msm8974 \
    libgps.utils \
    libloc_core \
    libloc_eng

GPS_CONF := device/samsung/mondrianwifi/gps/etc/gps.conf

PRODUCT_COPY_FILES += \
    $(GPS_CONF):/system/etc/gps.conf \
    device/samsung/mondrianwifi/gps/etc/sap.conf:/system/etc/sap.conf

# Keylayouts
PRODUCT_COPY_FILES += \
    device/samsung/mondrianwifi/keylayout/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl \
    device/samsung/mondrianwifi/keylayout/Button_Jack.kl:system/usr/keylayout/Button_Jack.kl \
    device/samsung/mondrianwifi/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/samsung/mondrianwifi/keylayout/philips_remote_ir.kl:system/usr/keylayout/philips_remote_ir.kl \
    device/samsung/mondrianwifi/keylayout/samsung_remote_ir.kl:system/usr/keylayout/samsung_remote_ir.kl \
    device/samsung/mondrianwifi/keylayout/sec_touchscreen.kl:system/usr/keylayout/sec_touchscreen.kl \
    device/samsung/mondrianwifi/keylayout/ue_rf4ce_remote.kl:system/usr/keylayout/ue_rf4ce_remote.kl

# NFC doesn't exist

PRODUCT_COPY_FILES_OVERRIDES += \
   system/etc/permissions/com.android.nfc_extras.xml \
   system/etc/permissions/android.hardware.nfc.xml \
   system/etc/permissions/android.hardware.nfc.hce.xml

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    initlogo.rle \
    init.bt.rc \
    init.carrier.rc \
    init.crda.sh \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.ril.rc \
    init.target.rc \
    ueventd.qcom.rc

# HAL
PRODUCT_PACKAGES += \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    memtrack.msm8974 \
    power.msm8974

# Audio
PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio_policy.msm8974 \
    audio.primary.msm8974 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    tinymix

# Wifi
PRODUCT_PACKAGES += \
    macloader \
    crda \
    regulatory.bin \
    linville.key.pub.pem \
    wcnss_service

PRODUCT_COPY_FILES += \
    kernel/samsung/mondrianwifi/drivers/net/wireless/prima/firmware_bin/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    kernel/samsung/mondrianwifi/drivers/net/wireless/prima/firmware_bin/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    $(LOCAL_PATH)/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# libxml2 is needed for camera
PRODUCT_PACKAGES += libxml2

# Camera Wrapper
PRODUCT_PACKAGES += \
    camera.msm8974

# IR packages
PRODUCT_PACKAGES += \
    consumerir.msm8974
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Lights
PRODUCT_PACKAGES += lights.MSM8974

# QC Perf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=/vendor/lib/libqc-opt.so

#common build.props
PRODUCT_PROPERTY_OVERRIDES += \
    ro.chipname=msm8974 \
    ro.sf.lcd_density=320 \
    ro.opengles.version=196608 \
    persist.timed.enable=true \
    keyguard.no_require_sim=true

# Radio properties
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libsec-ril.so \
    ril.subscription.types=NV,RUIM \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    ro.use_data_netmgrd=true \
    persist.data.netmgrd.qos.enable=true \
    persist.radio.add_power_save=1 \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.radio.lte_vrat_report=1 \
    persist.rild.nitz_plmn="" \
    persist.rild.nitz_long_ons_0="" \
    persist.rild.nitz_long_ons_1="" \
    persist.rild.nitz_long_ons_2="" \
    persist.rild.nitz_long_ons_3="" \
    persist.rild.nitz_short_ons_0="" \
    persist.rild.nitz_short_ons_1="" \
    persist.rild.nitz_short_ons_2="" \
    persist.rild.nitz_short_ons_3=""

# msm_rng entropy feeder
PRODUCT_PACKAGES += \
    qrngd \
    qrngp

# Wifi
PRODUCT_COPY_FILES += \
   device/samsung/mondrianwifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
   device/samsung/mondrianwifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

# Keymaster
PRODUCT_PACKAGES += \
    keystore.msm8974

# call common msm8960
$(call inherit-product, device/samsung/msm8960-common/msm8960.mk)

# call dalvik heap config
$(call inherit-product, frameworks/native/build/tablet-7in-xhdpi-2048-dalvik-heap.mk)

# call hwui memory config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)
