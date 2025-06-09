#!/bin/bash

rm -rf .repo/local_manifests/
echo "=================="
echo "Remove LOCAL MANIFEST success"
echo "=================="

# Rom source repo
repo init -u https://github.com/BlueOS/android -b lineage-20.0 --git-lfs
echo "=================="
echo "Repo INIT success"
echo "=================="

# Clone Device tree repository
rm -rf device/xiaomi/mojito
git clone --depth=1 https://github.com/OliverSyx/android_device_xiaomi_mojito -b BlueOS device/xioami/mojito
echo "=================="
echo "Clone DT success"
echo "=================="

rm -rf vendor/xiaomi/mojito
git clone --depth=1 https://github.com/OliverSyx/android_vendor_xiaomi_mojito -b BlueOS vendor/xiaomi/mojito
echo "=================="
echo "Clone VT success"
echo "=================="

rm -rf kernel/xiaomi/mojito
git clone --depth=1 https://github.com/OliverSyx/android_kernel_xiaomi_mojito -b BlueOS kernel/xiaomi/mojito
echo "=================="
echo "Clone KT success"
echo "=================="

rm -rf vendor/xiaomi/mojito-leicacamera
git clone --depth=1 https://gitlab.com/pnplusplus/android_vendor_xiaomi_mojito-leicacamera vendor/xiaomi/mojito-leicacamera
echo "============================"
echo "Clone LEICA success"
echo "============================"

# Sync the repositories
/opt/crave/resync.sh
echo "=================="
echo "Repo SYNC success"
echo "=================="

# Set up build environment
source build/envsetup.sh

# Lunch
lunch lineage_mojito_userdebug

# Make cleaninstall
make installclean

# Build rom
mka bacon
