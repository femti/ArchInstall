#!/usr/bin/env bash
set -e


echo '==== Install YAY ===='
su -l wlad <<< $(cat << YAY
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd -
rm -rf /tmp/yay
YAY
)

echo '==== Inatall YAY packages ===='
su -l wlad <<< $(cat <<< AURPROG
yay -S --noconfirm --needed timeshift pycharm-community-edition raindrop evernote tradingview  insync-nautilus insync ttf-jetbrains-mono-nerd ttf-noto-nerd plymouth-theme-monoarch gnome-shell-extension-rounded-window-corners gnome-shell-extension-dash-to-dock gnome-shell-extension-openweather gnome-shell-extension-appindicator gnome-shell-extension-blur-my-shell gnome-shell-extension-gsconnect gnome-shell-extension-gtk4-desktop-icons-ng gnome-shell-extension-status-area-horizontal-spacing-git
AURPROG
)



