#!/usr/bin/env bash
set -e

echo '==== Install add package ===='
pacman -S --noconfirm --needed alacarte eog-plugins geany geary geany-plugins gnome-epub-thumbnailer ntfs-3g unrar p7zip dbus-broker tlp acpi acpi_call acpid plymouth ttf-droid noto-fonts ttf-roboto ttf-ubuntu-font-family ttf-fira-mono ttf-hack ttf-fira-code ttf-jetbrains-mono inter-font mesa-utils xorg-xdpyinfo xorg-xinit xorg-xinput xorg-xkill xorg-xrandr xf86-video-intel b43-fwcutter broadcom-wl-dkms dhclient dnsmasq dnsutils ethtool modemmanager networkmanager-openconnect networkmanager-openvpn nss-mdns usb_modeswitch bash-completion bluez-utils ffmpegthumbnailer gst-libav gst-plugins-ugly libdvdcss libopenraw mlocate efitools haveged nfs-utils nilfs-utils ntp dmidecode dmraid hdparm hwdetect lsscsi mtools sg3_utils sof-firmware intel-ucode gnome-power-manager gnome-shell-extension-appindicator webp-pixbuf-loader tlp-rdw upower thermald irqbalance

echo '==== Remove unnessary packages ===='
sudo pacman -R --noconfirm vim htop cheese yelp gnome-user-docs gnome-tour

echo '==== Start needed servises ===='
systemctl --user mask org.gnome.SettingsDaemon.Wacom.service
systemctl --user mask org.gnome.SettingsDaemon.A11ySettings.service
systemctl mask NetworkManager-wait-online.service
systemctl enable dbus-broker.service
systemctl enable fstrim.timer
systemctl enable acpid.service
systemctl enable bluetooth
systemctl enable tlp
systemctl enable upower
systemctl enable thermald
systemctl enable irqbalance

