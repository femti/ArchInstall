#!/usr/bin/env bash
set -e

echo '==== Instaling THEME ===='

su -l wlad <<< $(cat << THEM
cp /root/where/background /home/wlad/.config/
cd /home/wlad
mkdir .myscripts
cd .myscripts
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone https://github.com/vinceliuice/WhiteSur-cursors.git
THEM
)
cd /home/wlad/.myscript/WhiteSur-icon-theme
./install.sh -t all
cd /home/wlad/.myscript/WhiteSur-cursors
./install.sh
cd /home/wlad/.myscript/WhiteSur-gtk-theme
./install.sh -t all -c Light -c Dark -b "/home/wlad/.config/background"
./tweaks.sh -g -n -N -b "/home/wlad/.config/background"
./tweaks.sh -F
./tweaks.sh -d -c Light
flatpak override --filesystem=xdg-config/gtk-4.0

echo '==== Install Light Theme ===='
su -l wlad <<< $(cat << SIT
gsettings set org.gnome.shell.extensions.user-theme name "WhiteSur-Light"
gsettings set org.gnome.desktop.interface gtk-theme WhiteSur-Light
gsettings set org.gnome.desktop.interface icon-theme  WhiteSur-dark
gsettings set org.gnome.desktop.interface cursor-theme WhiteSur-cursors
gsettings set org.gnome.desktop.interface color-scheme prefer-light
gsettings set org.gnome.desktop.interface document-font-name "Roboto 10"
gsettings set org.gnome.desktop.interface font-name "Roboto 10"
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 10"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Roboto Medium 10"
gsettings set org.gnome.desktop.wm.preferences theme "WhiteSur-Light"
bash /home/wlad/.myscripts/WhiteSur-gtk-theme/install.sh -l -c Light
echo 'gtk-hint-font-metrics=1' >> /home/wlad/.config/gtk-4.0/settings.ini
SIT
)
cd -

