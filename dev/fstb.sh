#!/usr/bin/env bash
set -e

echo '==== change FSTAB ===='
sed -i '/btrfs/s/relatime/noatime,ssd,space_cache=v2,compress=zstd:3/g' /home/wlad/dev/fstab1
sed -i '/vfat/s/relatime/noatime/' /home/wlad/dev/fstab1
# noatime,ssd,space_cache=v2,compress=zstd:3
