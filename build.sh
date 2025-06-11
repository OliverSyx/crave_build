#!/bin/bash

rm -rf .repo/local_manifests/
rm -rf device/xiaomi/mojito
rm -rf vendor/xiaomi/mojito
rm -rf kernel/xiaomi/mojito
rm -rf vendor/private/keys
rm -rf vendor/xiaomi/mojito-leicacamera
echo "=================="
echo "Remove LOCAL MANIFEST success"
echo "=================="

# Rom source repo
repo init -u https://github.com/BlueOS/android -b lineage-20.0 --git-lfs
echo "=================="
echo "Repo INIT success"
echo "=================="

# Clone Device tree repository
git clone https://github.com/OliverSyx/android_device_xiaomi_mojito -b BlueOS device/xiaomi/mojito
echo "=================="
echo "Clone DT success"
echo "=================="

git clone --depth=1 https://github.com/OliverSyx/android_vendor_xiaomi_mojito -b BlueOS vendor/xiaomi/mojito
echo "=================="
echo "Clone VT success"
echo "=================="

git clone --depth=1 https://github.com/OliverSyx/android_kernel_xiaomi_mojito -b BlueOS kernel/xiaomi/mojito
echo "=================="
echo "Clone KT success"
echo "=================="

git clone --depth=1 https://github.com/OliverSyx/android_vendor_private_keys -b BlueOS vendor/private/keys
echo "=================="
echo "Clone KEYS success"
echo "=================="

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
. build/envsetup.sh

# Lunch
lunch lineage_mojito-userdebug

# Make cleaninstall
make installclean

# Build rom
mka bacon
