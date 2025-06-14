#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/xiaomi/mojito
rm -rf vendor/xiaomi/mojito
rm -rf kernel/xiaomi/mojito
rm -rf vendor/private/keys
rm -rf vendor/xiaomi/mojito-leicacamera
echo "=================="
echo "Remove LOCAL MANIFEST success"
echo "=================="

# Rom source repo
repo init -u https://github.com/SparkOS-Next/manifest -b pyro-next
echo "=================="
echo "Repo INIT success"
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
lunch spark_mojito-user

# Make cleaninstall
make installclean

# Build rom
mka bacon
