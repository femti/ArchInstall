#!/usr/bin/env bash
set -e

echo '==== Install Plymouth Theme and edit GRUB ===='
# yay -S --noconfirm  plymouth-theme-monoarch
echo 'add plymouth to HOOK'
sed -i '/^HOOK/s/ udev / udev plymouth /' /etc/mkinitcpio.conf
sudo plymouth-set-default-theme -R monoarch
echo 'add to GRUB splash, hidden and time'
sed -i '/GRUB_TIMEOUT=/s/5/1/'  /etc/default/grub
sed -i '/GRUB_TIMEOUT_STYLE=/s/menu/hidden/'  /etc/default/grub
sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/s/ quiet/ quiet splash/'  /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo '==== Change FSTAB ===='
sed -i '/btrfs/s/relatime/noatime,ssd,space_cache=v2,compress=zstd:3/g' /etc/fstab
sed -i '/vfat/s/relatime/noatime/' /etc/fstab

echo 'vm.swappiness=10' >> /etc/sysctl.d/99-sysctl.conf 

