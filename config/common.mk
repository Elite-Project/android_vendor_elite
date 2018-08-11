# Copyright 2019 The Elite-Project
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

# Enable SIP+VoIP
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Include APN information
PRODUCT_COPY_FILES += vendor/elite/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# Copy init file
PRODUCT_COPY_FILES += vendor/elite/prebuilt/root/init.elite.rc:root/init.elite.rc

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG := false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=0
endif

export VENDOR := elite

# Include hostapd configuration
PRODUCT_COPY_FILES += \
    vendor/elite/prebuilt/etc/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    vendor/elite/prebuilt/etc/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny \
    vendor/elite/prebuilt/etc/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept

ifneq ($(HOST_OS),linux)
ifneq ($(sdclang_already_warned),true)
$(warning **********************************************)
$(warning * SDCLANG is not supported on non-linux hosts.)
$(warning **********************************************)
sdclang_already_warned := true
endif
else
# include definitions for SDCLANG
include vendor/elite/sdclang/sdclang.mk
endif

# Include vendor SEPolicy changes
include vendor/elite/sepolicy/sepolicy.mk
