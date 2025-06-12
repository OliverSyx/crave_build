#!/bin/bash

rm -rf .repo/local_manifests
rm -rf vendor/xiaomi/mojito-leicacamera
echo "============================="
echo "Remove LOCAL MANIFEST success"
echo "============================="

# Rom source repo
repo init -u https://github.com/BlueOS/android -b lineage-20.0 --git-lfs
echo "================="
echo "Repo INIT success"
echo "================="

# Clone Device tree repository
git clone -b lineage-20.0 https://github.com/OliverSyx/local_manifests.git .repo/local_manifests
echo "============================"
echo "Clone local_manifest success"
echo "============================"

# Sync the repositories
/opt/crave/resync.sh
echo "================="
echo "Repo SYNC success"
echo "================="

# Leica Camera
git clone --depth=1 https://gitlab.com/pnplusplus/android_vendor_xiaomi_mojito-leicacamera vendor/xiaomi/mojito-leicacamera
echo "==================="
echo "Clone LEICA success"
echo "==================="

# Set up build environment
. build/envsetup.sh

# Lunch
brunch mojito userdebug

# Make cleaninstall
make installclean

# Build rom
mka bacon
