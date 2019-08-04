# Eite-CAF versions.
CAF_VERSION := LA.UM.7.3.r1-07900-sdm845.0
ELITE_VERSION_FLAVOUR := Majesty
PLATFORM := 9.0
DATE := $(shell date +"%Y%m%d-%H%M")
ifndef ELITE_BUILD_TYPE

# Official build support
CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
ELITE_BUILD_TYPE ?= UNOFFICIAL

ifeq ($(ELITE_BUILD_TYPE),OFFICIAL)
  LIST = $(shell curl -s https://raw.githubusercontent.com/Elite-Project/android_vendor_elite/e9x/elite.devices)
  FOUND_DEVICE = $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      PRODUCT_PACKAGES += Updater
    else
      $(warning ALERT: Device $(CURRENT_DEVICE) is not OFFICIAL! Building UNOFFICIAL...)
      ELITE_BUILD_TYPE := UNOFFICIAL
    endif
endif
endif
# Set all versions
ELITE_VERSION := EliteCAF-v$(PLATFORM)-$(ELITE_VERSION_FLAVOUR)-$(ELITE_BUILD)-$(ELITE_BUILD_TYPE)-$(DATE)
ELITE_MOD_VERSION := EliteCAF-v$(PLATFORM)-$(ELITE_VERSION_FLAVOUR)-$(ELITE_BUILD)-$(ELITE_BUILD_TYPE)-$(DATE)
CUSTOM_FINGERPRINT := Elite-CAF/$(PLATFORM_VERSION)/$(ELITE_VERSION_FLAVOUR)/$(TARGET_PRODUCT)/$(shell date +%Y%m%d-%H:%M)
ELITE_RELEASETYPE := $(ELITE_BUILD)-$(ELITE_BUILD_TYPE)-$(DATE)

# Include versioning information
PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=$(ELITE_MOD_VERSION) \
    ro.elite.version=$(ELITE_VERSION) \
    ro.elite.releasetype=$(ELITE_RELEASETYPE) \
    ro.caf.version=$(CAF_VERSION)
