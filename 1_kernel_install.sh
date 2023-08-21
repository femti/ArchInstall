#!/usr/bin/env bash
set -e


echo '===== Install Kernel ====='
curl -s https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc | sudo pacman-key --add -
pacman-key --finger 56C464BAAC421453
pacman-key --lsign-key 56C464BAAC421453
echo '[linux-surface]' >> /etc/pacman.conf
echo 'Server = https://pkg.surfacelinux.com/arch/' >> /etc/pacman.conf
pacman -Syu
pacman -S --noconfirm linux-surface linux-surface-headers iptsd
# pacman -S linux-surface-secureboot-mok
grub-mkconfig -o /boot/grub/grub.cfg

