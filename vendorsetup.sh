for device in $(cat $(gettop)/vendor/elite/elite.devices | sed -e 's/#.*$//' | awk '{printf "elite_%s-userdebug\n", $1}'); do
    add_lunch_combo $device;
done;

# SDClang Environment Variables
export SDCLANG_AE_CONFIG=vendor/elite/sdclang/sdclangAE.json
export SDCLANG_CONFIG=vendor/elite/sdclang/sdclang.json
export SDCLANG_SA_ENABLED=false
